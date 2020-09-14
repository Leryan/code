package vcpu

// SliceSize is the default size of the ResultStack.
// Each time more space is required, the stack will
// grow by that constant.
const SliceSize = 128

// ResultStack ...
type ResultStack struct {
	stack   []interface{}
	pointer int
}

// NewResultStack ...
func NewResultStack() ResultStack {
	rs := ResultStack{}
	rs.Init()
	return rs
}

// Init everything
func (rs *ResultStack) Init() {
	rs.pointer = 0
	rs.stack = make([]interface{}, SliceSize)
}

// Reset only the stack pointer
func (rs *ResultStack) Reset() {
	rs.pointer = 0
}

// Pop rewinds by 1 the result stack pointer then returns the result.
// This function does NOT checks boundaries of the result stack, meaning
// that an index error will crash your program.
func (rs *ResultStack) Pop() interface{} {
	rs.pointer--
	return rs.stack[rs.pointer]
}

func (rs *ResultStack) grow() {
	nstack := make([]interface{}, len(rs.stack)+SliceSize)
	copy(nstack, rs.stack)
	rs.stack = nstack
}

// Set the value on the given result stack
// pointer then increments the pointer.
// The resulting pointed address is alway an anusable result.
// This function does NOT checks boundaries of the result stack, meaning
// that an index error will crash your program.
func (rs *ResultStack) Set(rv interface{}) {
	if rs.pointer > len(rs.stack)-1 {
		rs.grow()
	}
	rs.stack[rs.pointer] = rv
	rs.pointer++
}
