package vcpu

import (
	"testing"
)

func cmpResstackValue(errorf func(string, ...interface{}), opstack *OPStack, idx int, res interface{}) {
	rv := opstack.resultStack.stack[idx]
	if rv != res {
		errorf("bad result, got %v wanted %v", rv, res)
	}
}

func getTestOPStack() *OPStack {
	ops := NewOPStack()
	return &ops
}

func TestOPEqFalse(t *testing.T) {
	opstack := getTestOPStack()
	opstack.resultStack.Set(true)
	opstack.resultStack.Set(false)
	OPEquals(opstack, nil, nil)

	cmpResstackValue(t.Errorf, opstack, 0, false)
}

func TestOPEqTrue(t *testing.T) {
	opstack := getTestOPStack()
	opstack.resultStack.Set(false)
	opstack.resultStack.Set(false)
	OPEquals(opstack, nil, nil)

	cmpResstackValue(t.Errorf, opstack, 0, true)
}

func TestOPNEqTrue(t *testing.T) {
	ops := getTestOPStack()
	ops.resultStack.Set(false)
	ops.resultStack.Set(true)
	OPNEquals(ops, nil, nil)

	cmpResstackValue(t.Errorf, ops, 0, true)
}

func TestOPNEqFalse(t *testing.T) {
	ops := getTestOPStack()
	ops.resultStack.Set(true)
	ops.resultStack.Set(true)
	OPNEquals(ops, nil, nil)

	cmpResstackValue(t.Errorf, ops, 0, false)
}
func TestOPAndFalse(t *testing.T) {
	opstack := getTestOPStack()
	opstack.resultStack.Set(true)
	opstack.resultStack.Set(false)
	OPAnd(opstack, nil, nil)

	cmpResstackValue(t.Errorf, opstack, 0, false)
}

func TestOPAndTrue(t *testing.T) {
	opstack := getTestOPStack()
	opstack.resultStack.Set(true)
	opstack.resultStack.Set(true)
	OPAnd(opstack, nil, nil)

	cmpResstackValue(t.Errorf, opstack, 0, true)
}

func TestOPOrTrue(t *testing.T) {
	ops := getTestOPStack()
	ops.resultStack.Set(false)
	ops.resultStack.Set(true)
	OPOr(ops, nil, nil)
	cmpResstackValue(t.Errorf, ops, 0, true)
}

func TestOPOrFalse(t *testing.T) {
	ops := getTestOPStack()
	ops.resultStack.Set(false)
	ops.resultStack.Set(false)
	OPOr(ops, nil, nil)
	cmpResstackValue(t.Errorf, ops, 0, false)
}

func TestOPNOOP(t *testing.T) {
	ops := getTestOPStack()
	OPNOOP(ops, nil, nil)

	cmpResstackValue(t.Errorf, ops, 0, nil)
}

func TestOPMvVal(t *testing.T) {
	ops := getTestOPStack()
	cmpResstackValue(t.Errorf, ops, 0, nil)
	OPMvVal(ops, true, nil)
	cmpResstackValue(t.Errorf, ops, 0, true)
}

func TestOPPrint(t *testing.T) {
	ops := getTestOPStack()
	ops.resultStack.Set("success")
	OPPrint(ops, nil, nil)
	if ops.resultStack.pointer != 0 {
		t.Errorf("bad result stack pointer value. want 0 got %d", ops.resultStack.pointer)
	}
}

func TestOPJump(t *testing.T) {
	ops := getTestOPStack()
	ops.lbladdr[".success"] = 3
	ops.Add(OP{Callable: OPNOOP})
	ops.Add(OP{
		Callable: OPJump,
		LVal:     ".success",
	})
	ops.Add(OP{Callable: OPNOOP})
	ops.Add(OP{
		Callable: OPMvVal,
		LVal:     "fail",
	})
	ops.Add(OP{
		Callable: OPMvVal,
		LVal:     "success",
	})
	ops.Run()
	cmpResstackValue(t.Errorf, ops, 0, "success")
}
