package vcpu

import (
	"testing"
)

func TestCompile(t *testing.T) {
	src := `
move 2
move 2
#comment
eq
move 3
move 3
eq
and
noop
jump .success
move fail
.success
move success`
	ops, err := Compile(DefaultOPMap(), src)
	if err != nil {
		t.Error(err)
	}
	ops.Run()
	if ops.err != nil {
		t.Errorf("error: %v", ops.err)
	}
	cmpResstackValue(t.Errorf, &ops, 0, true)
	cmpResstackValue(t.Errorf, &ops, 1, "success")
}

func TestCompileUnknown(t *testing.T) {
	src := `beurk 10`
	_, err := Compile(DefaultOPMap(), src)
	if err == nil {
		t.Error("compile did not returned error")
	}
}
