package vcpu

import (
	"testing"
)

func TestResultStack(t *testing.T) {
	rs := NewResultStack()
	if rs.pointer != 0 {
		t.Errorf("bad rs pointer value: %d", rs.pointer)
	}
	if len(rs.stack) != SliceSize {
		t.Errorf("bad rs lentgh: %d", len(rs.stack))
	}

	rs.Set(true)

	if rs.pointer != 1 {
		t.Errorf("bad rs pointer value: %d", rs.pointer)
	}

	rv := rs.Pop()
	if rs.pointer != 0 {
		t.Errorf("bad rs pointer value: %d", rs.pointer)
	}
	if !rv.(bool) {
		t.Errorf("bad value: %v", rv)
	}
}

func TestResultStackGrow(t *testing.T) {
	rs := NewResultStack()
	if len(rs.stack) != SliceSize {
		t.Errorf("bad rs length: %d", len(rs.stack))
	}

	rs.grow()

	if len(rs.stack) != SliceSize*2 {
		t.Errorf("bad rs length: %d", len(rs.stack))
	}
}

func TestResultStackSetGrow(t *testing.T) {
	rs := NewResultStack()
	for i := 0; i < SliceSize*2; i++ {
		rs.Set(true)
	}
	if len(rs.stack) != SliceSize*2 {
		t.Errorf("bad rs length: %d", len(rs.stack))
	}
}
