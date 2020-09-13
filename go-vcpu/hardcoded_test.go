package vcpu

import (
	"encoding/json"
	"io/ioutil"
	"os"
	"testing"
)

func hardcodedCheck(res interface{}) bool {
	ok := false
	comp, tok := res.(map[string]interface{})["component"].(string)
	if !tok {
		return false
	}
	reso, tok := res.(map[string]interface{})["resource"].(string)
	if !tok {
		return false
	}
	state, tok := res.(map[string]interface{})["state"].(float64)
	if !tok {
		return false
	}

	if comp == "comp1" && reso == "res1" && state == 2 {
		ok = true
	}

	return ok
}

func BenchmarkRuleHardcoded(b *testing.B) {
	doc, err := os.Open("doc.json")
	if err != nil {
		b.Error(err)
	}
	jdoc, err := ioutil.ReadAll(doc)
	if err != nil {
		b.Error(err)
	}

	var res interface{}
	err = json.Unmarshal(jdoc, &res)
	if err != nil {
		b.Error(err)
	}
	b.ResetTimer()
	for i := 0; i < b.N; i++ {
		ok := hardcodedCheck(res)
		if !ok {
			b.Error("bad result")
		}
	}
}
