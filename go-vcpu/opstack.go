package vcpu

import (
	"encoding/json"
)

// OPStack represents the vCPU with a result stack, a pointer and an op stack.
type OPStack struct {
	stack       []OP
	pointer     uint64
	resultStack ResultStack
	jdoc        interface{}
	err         error
	lbladdr     map[string]uint64
}

// NewOPStack returns a fully initialized
func NewOPStack() OPStack {
	ops := OPStack{
		resultStack: NewResultStack(),
	}
	ops.Init()
	return ops
}

// Init the vCPU
func (os *OPStack) Init() {
	os.Reset()
	os.lbladdr = make(map[string]uint64)
}

// Reset the op pointer and result stack.
func (os *OPStack) Reset() {
	os.pointer = 0
	os.err = nil
	os.resultStack.Reset()
}

// Add an operand to the op stack.
func (os *OPStack) Add(op OP) int {
	os.stack = append(os.stack, op)
	return len(os.stack) - 1
}

// Next moves the opstack pointer to the next op.
// Returns true if os.pointer is out of the stack.
func (os *OPStack) Next() bool {
	os.pointer++
	return os.pointer < uint64(len(os.stack))
}

// Load document in opstack memory.
func (os *OPStack) Load(bdoc []byte) error {
	err := json.Unmarshal(bdoc, &os.jdoc)
	if err != nil {
		return err
	}
	return nil
}

// RunOP call the current op pointed by os.pointer
func (os *OPStack) RunOP() {
	os.stack[os.pointer].Run(os)
}

// Run the program. It ends when the current pointer value equals
// the stack length or more, returning an error with empty string.
// If the error does not contain an empty string, it is an actual error.
func (os *OPStack) Run() {
	os.RunOP()
	if os.err != nil {
		return
	}
	for os.Next() {
		os.RunOP()
		if os.err != nil {
			return
		}
	}
}
