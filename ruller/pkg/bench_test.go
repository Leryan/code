package pkg_test

import (
	"encoding/json"
	"eventfilter/pkg/compiler"
	"eventfilter/pkg/types"
	"io/ioutil"
	"os/exec"
	"path"
	"plugin"
	"testing"
)

func BenchmarkRunner(b *testing.B) {
	srules := `[
		{
			"$and": [
				{"field1": {"$eq": "boo1"}},
				{"field2": {"$ne": "boo2"}},
				{"$or": [
					{"field3": "pwet"},
					{"field4": "zoo"}
				]}
			]
		}
	]`

	var rules []map[string]interface{}
	err := json.Unmarshal([]byte(srules), &rules)
	if err != nil {
		b.Fatal(err)
	}

	c := compiler.NewCompiler(rules)
	result, err := c.Compile(true)
	if err != nil {
		b.Fatal(err)
	}
	rulego, err := ioutil.TempFile("", "rule.go")
	if err != nil {
		b.Fatal(err)
	}
	//defer os.Remove(rulego.Name())
	_, err = rulego.WriteString(result)
	if err != nil {
		b.Fatal(err)
	}

	rulego.Sync()

	cmd := exec.Command("/bin/sh", "-c", "mv "+rulego.Name()+" "+rulego.Name()+".go && go build -ldflags=\"-s -w\" -buildmode=plugin "+rulego.Name()+".go")
	rulego.Close()
	output, err := cmd.CombinedOutput()
	if err != nil {
		b.Fatalf("build: %s: %v", string(output), err)
	}

	// Runner
	inputsBytes := []byte(`[{
		"field1": "boo1",
		"field2": "kapoue",
		"field3": "pwet",
		"field4": "zoo"
	}]`)
	var inputs []map[string]interface{}
	if err = json.Unmarshal(inputsBytes, &inputs); err != nil {
		b.Fatal(err)
	}

	plug, err := plugin.Open(path.Base(rulego.Name()) + ".so")
	if err != nil {
		b.Fatalf("plugin open: %v", err)
	}

	collectSym, err := plug.Lookup("CollectFilters")
	if err != nil {
		b.Fatalf("plugin CollectFilters symbol: %v", err)
	}

	prepareSym, err := plug.Lookup("Prepare")
	if err != nil {
		b.Fatalf("plugin CollectFilters symbol: %v", err)
	}

	collectFunc := collectSym.(func(*[]types.Filter) error)
	prepareFunc := prepareSym.(func() error)

	filters := make([]types.Filter, 0)

	if err = prepareFunc(); err != nil {
		b.Fatalf("prepare failure: %v", err)
	}
	collectFunc(&filters)

	b.ResetTimer()
	for i, filter := range filters {
		for c := 0; c < b.N; c++ {
			filter.SetInput(inputs[0])
			if !filter.Check() {
				b.Fatalf("filter %d did NOT match input", i)
			}
		}
	}

}
