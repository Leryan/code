package vcpu

import (
	"io/ioutil"
	"os"
	"testing"
)

func BenchmarkRuleCPU(b *testing.B) {
	src, err := os.Open("rule.vasm")
	if err != nil {
		b.Error(err)
	}
	bsrc, err := ioutil.ReadAll(src)
	if err != nil {
		b.Error(err)
	}

	doc, err := os.Open("doc.json")
	if err != nil {
		b.Error(err)
	}
	bdoc, err := ioutil.ReadAll(doc)
	if err != nil {
		b.Error(err)
	}

	prog, err := Compile(DefaultOPMap(), string(bsrc))
	if err != nil {
		b.Errorf("compile error: %v", err)
	}
	prog.Load(bdoc)
	b.ResetTimer()
	for i := 0; i < b.N; i++ {
		prog.Run()
		if !prog.resultStack.stack[0].(bool) {
			b.Errorf("bad value: %s", prog.resultStack.stack[0])
		}
		prog.Reset()
	}
}
