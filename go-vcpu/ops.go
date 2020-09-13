package vcpu

import (
	"errors"
	"fmt"
)

// OP is an operand.
type OP struct {
	Instruction string
	LVal        interface{}
	RVal        interface{}
	Callable    func(*OPStack, interface{}, interface{})
}

// OPLoad load a value from a field of the json document
func OPLoad(os *OPStack, lval interface{}, rval interface{}) {
	switch val := os.jdoc.(type) {
	case map[string]interface{}:
		os.resultStack.Set(val[lval.(string)])
	default:
		os.err = errors.New("cannot access data1")
	}
}

// OPNOOP does absolutely nothing. Cannot fail.
func OPNOOP(os *OPStack, lval interface{}, rval interface{}) {
}

// OPEquals compares field and value.
func OPEquals(os *OPStack, lval interface{}, rval interface{}) {
	r1 := os.resultStack.Pop()
	r2 := os.resultStack.Pop()
	if r1 == r2 {
		os.resultStack.Set(true)
	} else {
		os.resultStack.Set(false)
	}
}

// OPNEquals compares field and value.
func OPNEquals(os *OPStack, lval interface{}, rval interface{}) {
	r1 := os.resultStack.Pop()
	r2 := os.resultStack.Pop()
	if r1 == r2 {
		os.resultStack.Set(false)
	} else {
		os.resultStack.Set(true)
	}
}

// OPMvVal moves the value param on the result stack.
func OPMvVal(os *OPStack, lval interface{}, rval interface{}) {
	os.resultStack.Set(lval)
}

// OPPrint prints the latest result.
func OPPrint(os *OPStack, lval interface{}, rval interface{}) {
	res := os.resultStack.Pop()
	fmt.Println(res)
}

// OPAnd makes AND between the two top results.
func OPAnd(os *OPStack, lval interface{}, rval interface{}) {
	r1 := os.resultStack.Pop()
	r2 := os.resultStack.Pop()
	if r1.(bool) && r2.(bool) {
		os.resultStack.Set(true)
	} else {
		os.resultStack.Set(false)
	}
}

// OPOr makes OR between the two top results.
func OPOr(os *OPStack, lval interface{}, rval interface{}) {
	r1 := os.resultStack.Pop()
	r2 := os.resultStack.Pop()
	if r1.(bool) || r2.(bool) {
		os.resultStack.Set(true)
	} else {
		os.resultStack.Set(false)
	}
}

// OPJump goes to the given label
func OPJump(os *OPStack, lval interface{}, rval interface{}) {
	os.pointer = os.lbladdr[lval.(string)]
}

// OPJumpTrue goes to the given label if latest result is btrue
func OPJumpTrue(os *OPStack, lval interface{}, rval interface{}) {
	r := os.resultStack.Pop()
	if r.(bool) {
		os.pointer = os.lbladdr[lval.(string)]
	}
}

// OPJumpFalse goes to the given label if latest result is bfalse
func OPJumpFalse(os *OPStack, lval interface{}, rval interface{}) {
	r := os.resultStack.Pop()
	if !r.(bool) {
		os.pointer = os.lbladdr[lval.(string)]
	}
}

// Run the current operand.
func (op *OP) Run(os *OPStack) {
	op.Callable(os, op.LVal, op.RVal)
}
