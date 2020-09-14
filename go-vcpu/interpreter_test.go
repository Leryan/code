package vcpu

import (
	"encoding/json"
	_ "fmt"
	"io/ioutil"
	"log"
	"os"
	"testing"
)

func checkOr(subvallist []interface{}, event interface{}) bool {
	for _, subvalitem := range subvallist {
		switch subvalmap := subvalitem.(type) {
		case map[string]interface{}:
			if check(subvalmap, event) {
				return true
			}
		default:
			return false
		}
	}
	return false
}

func checkAnd(subvallist []interface{}, event interface{}) bool {
	result := true
	for _, subvalitem := range subvallist {
		switch subvalmap := subvalitem.(type) {
		case map[string]interface{}:
			result = result && check(subvalmap, event)
		default:
			return false
		}
	}
	return result
}

func checkEq(key string, val interface{}, event interface{}) bool {
	switch value := val.(type) {
	case string:
		return checkEqString(key, value, event)
	case float64:
		return checkEqNum(key, value, event)
	default:
		return false
	}
}

func checkEqString(key, val string, event interface{}) bool {
	switch evt := event.(type) {
	case map[string]interface{}:
		switch evtval := evt[key].(type) {
		case string:
			return evtval == val
		default:
			return false
		}
	default:
		return false
	}
}

func checkEqNum(key string, val float64, event interface{}) bool {
	switch evt := event.(type) {
	case map[string]interface{}:
		switch evtval := evt[key].(type) {
		case float64:
			return evtval == val
		default:
			return false
		}
	default:
		return false
	}
}

func check(mfilter map[string]interface{}, event interface{}) bool {
	for key, value := range mfilter {
		switch key {
		case "$and":
			switch subvallist := value.(type) {
			case []interface{}:
				return checkAnd(subvallist, event)
			default:
				return false
			}
		case "$or":
			switch subvallist := value.(type) {
			case []interface{}:
				return checkOr(subvallist, event)
			default:
				return false
			}
		default:
			return checkEq(key, value, event)
		}
	}
	return false
}

func BenchmarkRuleInterpreter(b *testing.B) {
	rule, err := os.Open("rule.json")
	if err != nil {
		log.Fatalln(err)
	}
	doc, err := os.Open("doc.json")
	if err != nil {
		log.Fatalln(err)
	}
	jrule, err := ioutil.ReadAll(rule)
	if err != nil {
		log.Fatalln(err)
	}
	jdoc, err := ioutil.ReadAll(doc)
	if err != nil {
		log.Fatalln(err)
	}
	var mfilter map[string]interface{}
	var event interface{}
	err = json.Unmarshal(jrule, &mfilter)
	if err != nil {
		log.Fatalln(err)
	}
	err = json.Unmarshal(jdoc, &event)
	if err != nil {
		log.Fatalln(err)
	}
	b.ResetTimer()
	for i := 0; i < b.N; i++ {
		ok := check(mfilter, event)
		if !ok {
			b.Error("bad result")
		}
	}
}
