package compiler

import (
	"encoding/json"
	"fmt"
	"log"
	"runtime/debug"
	"strconv"
	"strings"
)

type Compiler struct {
	functionCounter int
	valueCounter    int
	values          map[int]interface{}
	rules           []map[string]interface{}
}

func catchCompilePanic() {
	if r := recover(); r != nil {
		log.Printf("compile error: %v", r)
		debug.PrintStack()
	}
}

func (f *Compiler) funcID() string {
	return fmt.Sprintf("rf%d", f.functionCounter)
}

func (f *Compiler) compileOR(rules []interface{}, currentField string) (string, string, error) {
	f.functionCounter++

	funcID := f.funcID()

	template := `
func (f *dasFilter@RULECOUNT@) @FUNCID@() bool {
	return @OR@
}
	`

	funcIDs := make([]string, 0)

	for _, rule := range rules {
		tres, fid, err := f.compileMap(rule.(map[string]interface{}), currentField)
		if err != nil {
			return "", "", err
		}
		template += tres

		funcIDs = append(funcIDs, "f."+fid+"()")
	}

	template = strings.Replace(template, "@OR@", strings.Join(funcIDs, " || "), 1)
	template = strings.Replace(template, "@FUNCID@", funcID, 1)

	return template, funcID, nil
}

func (f *Compiler) compileAND(rules []interface{}, currentField string) (string, string, error) {
	f.functionCounter++

	funcID := f.funcID()

	template := `
func (f *dasFilter@RULECOUNT@) @FUNCID@() bool {
	return @AND@
}
	`

	funcIDs := make([]string, 0)

	for _, rule := range rules {
		tres, fid, err := f.compileMap(rule.(map[string]interface{}), currentField)
		if err != nil {
			return "", "", err
		}
		template += tres

		funcIDs = append(funcIDs, "f."+fid+"()")
	}

	template = strings.Replace(template, "@AND@", strings.Join(funcIDs, " && "), 1)
	template = strings.Replace(template, "@FUNCID@", funcID, 1)

	return template, funcID, nil
}

func (f *Compiler) compileEQ(field string, rval interface{}, negate bool) (string, string, error) {
	f.valueCounter++
	f.functionCounter++
	f.values[f.valueCounter] = rval

	funcID := f.funcID()

	template := `
func (f *dasFilter@RULECOUNT@) @FUNCID@() bool {
	return @NEGATE@functions.Equal(f.input, usableValues, @FIELD@, "@VALUECOUNTER@")
}
`

	template = strings.Replace(template, "@FUNCID@", funcID, -1)
	template = strings.Replace(template, "@FIELD@", strconv.Quote(field), -1)
	template = strings.Replace(template, "@VALUECOUNTER@", strconv.FormatInt(int64(f.valueCounter), 10), -1)
	if negate {
		template = strings.Replace(template, "@NEGATE@", "!", -1)
	} else {
		template = strings.Replace(template, "@NEGATE@", "", -1)
	}

	return template, funcID, nil
}

func (f *Compiler) compileNEQ(field string, rval interface{}) (string, string, error) {
	return f.compileEQ(field, rval, true)
}

func (f *Compiler) compileUnknown(field string, rval interface{}) (string, string, error) {
	switch t := rval.(type) {
	case map[string]interface{}:
		if len(t) > 1 {
			return "", "", fmt.Errorf("should use $and instead: %s: %v", field, rval)
		}
		return f.compileMap(t, field)
	default:
		return f.compileEQ(field, rval, false)
	}
}

func (f *Compiler) compileMap(rule map[string]interface{}, lastField string) (string, string, error) {
	var cerr error
	result := ""
	funcID := ""

	for k, v := range rule {
		switch k {
		case "$and":
			tres, fid, err := f.compileAND(v.([]interface{}), lastField)
			result += tres
			funcID = fid
			cerr = err
		case "$or":
			tres, fid, err := f.compileOR(v.([]interface{}), lastField)
			result += tres
			funcID = fid
			cerr = err
		case "$ne":
			tres, fid, err := f.compileNEQ(lastField, v)
			result += tres
			funcID = fid
			cerr = err
		case "$eq":
			tres, fid, err := f.compileEQ(lastField, v, false)
			result += tres
			funcID = fid
			cerr = err
		default:
			tres, fid, err := f.compileUnknown(k, v)
			result += tres
			funcID = fid
			cerr = err
		}

		if cerr != nil {
			return "", "", cerr
		}
	}

	return result, funcID, cerr
}

func (f *Compiler) CompileRule(ruleCount int, rule map[string]interface{}) (string, error) {
	code, call, err := f.compileMap(rule, "")

	if err != nil {
		return "", err
	}

	template := `

type dasFilter@RULECOUNT@ struct {
	input map[string]interface{}
	values map[int]interface{}
}

` + code + `

func (f *dasFilter@RULECOUNT@) Check() bool {
	return f.` + call + `()
}

func (f *dasFilter@RULECOUNT@) SetInput(input map[string]interface{}) {
	f.input = input
}
`

	template = strings.Replace(template, "@RULECOUNT@", strconv.FormatInt(int64(ruleCount), 10), -1)

	return template, nil
}

// Compile ...
func (f *Compiler) Compile(standalone bool) (string, error) {
	defer catchCompilePanic()

	f.values = make(map[int]interface{})
	startCode := `
package main

import (
	"encoding/json"
	"eventfilter/pkg/functions"
	"eventfilter/pkg/types"
)

var values = @DUMPEDVALUES@

var usableValues = make(map[string]interface{})

func Prepare() error {
	return json.Unmarshal([]byte(values), &usableValues)
}

`

	code := ""

	for ruleCount, rule := range f.rules {
		rulecode, err := f.CompileRule(ruleCount, rule)
		if err != nil {
			return "", fmt.Errorf("compile rule %d error: %v", ruleCount, err)
		}
		code += "\n" + rulecode
	}
	runCode := `
func CollectFilters(filters *[]types.Filter) error {
	@FILTERS@

	if err := Prepare(); err != nil {
		return err
	}

	return nil
}
`

	filtersCode := ""
	filtersTemplate := "*filters = append(*filters, &dasFilter@RULECOUNT@{})"

	for i := 0; i < len(f.rules); i++ {
		filtersCode += strings.Replace(filtersTemplate, "@RULECOUNT@", strconv.FormatInt(int64(i), 10), 1) + "\n"
	}

	startCode = strings.Replace(startCode, "@DUMPEDVALUES@", strconv.Quote(f.dumpValues()), 1)

	return startCode + code + strings.Replace(runCode, "@FILTERS@", filtersCode, 1), nil
}

func (f *Compiler) dumpValues() string {
	b, err := json.Marshal(f.values)
	if err != nil {
		panic(err)
	}
	return string(b)
}

// NewCompiler ...
func NewCompiler(rules []map[string]interface{}) *Compiler {
	return &Compiler{
		rules:  rules,
		values: make(map[int]interface{}),
	}
}
