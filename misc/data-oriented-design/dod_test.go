package dod_test

import (
	"testing"
)

type Value struct {
	S1  string
	S2  string
	S3  string
	S4  string
	S5  string
	S6  string
	S7  string
	S8  string
	S9  string
	S10 string
}

var v Value
var s string

type Ctrl struct {
	direct   map[int]Value
	vdirect  map[int]string
	indirect map[int]int
	vec      []Value
	vecv     []string
}

func NewCtrl(elems int) *Ctrl {
	return &Ctrl{
		direct:   make(map[int]Value),
		vdirect:  make(map[int]string),
		indirect: make(map[int]int),
		vec:      make([]Value, elems),
		vecv:     make([]string, elems),
	}
}

func (c *Ctrl) Len() int {
	return len(c.vec)
}

func (c *Ctrl) Gen() {
	for i := 0; i < len(c.vec); i++ {
		c.direct[i] = Value{
			S1:  "nuasritenruste1",
			S2:  "nuasritenruste2",
			S3:  "nuasritenruste3",
			S4:  "nuasritenruste4",
			S5:  "nuasritenruste5",
			S6:  "nuasritenruste6",
			S7:  "nuasritenruste7",
			S8:  "nuasritenruste8",
			S9:  "nuasritenruste9",
			S10: "nuasritenruste0",
		}
		c.vdirect[i] = c.direct[i].S5
		c.vec[i] = c.direct[i]
		c.vecv[i] = c.vec[i].S5
		c.indirect[i] = i
	}
}

func (c *Ctrl) GetDirectValue(key int) Value {
	return c.direct[key]
}

func (c *Ctrl) GetIndirectValue(key int) Value {
	return c.vec[c.indirect[key]]
}

func (c *Ctrl) GetDirectField(key int) string {
	return c.vdirect[key]
}

func (c *Ctrl) GetIndirectField(key int) string {
	return c.vecv[c.indirect[key]]
}

func BenchmarkMapDirectValue(b *testing.B) {
	c := NewCtrl(100000)
	c.Gen()

	b.ResetTimer()
	for i := 0; i < b.N; i++ {
		v = c.GetDirectValue(i)
	}
}

func BenchmarkIndirectValue(b *testing.B) {
	c := NewCtrl(100000)
	c.Gen()

	b.ResetTimer()
	for i := 0; i < b.N; i++ {
		v = c.GetIndirectValue(i)
	}
}

func BenchmarkMapDirectField(b *testing.B) {
	c := NewCtrl(100000)
	c.Gen()

	b.ResetTimer()
	for i := 0; i < b.N; i++ {
		s = c.GetDirectField(i)
	}
}

func BenchmarkIndirectField(b *testing.B) {
	c := NewCtrl(100000)
	c.Gen()

	b.ResetTimer()
	for i := 0; i < b.N; i++ {
		s = c.GetIndirectField(i)
	}
}
