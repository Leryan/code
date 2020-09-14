package cooltypes_test

import (
	"testing"

	"github.com/Leryan/go-cooltypes/cooltypes"

	c "github.com/smartystreets/goconvey/convey"
)

func TestPyMap(t *testing.T) {
	c.Convey("Setup", t, func() {
		m := cooltypes.NewPyMap()
		val := m.GetDef("none", 1).(int)

		c.So(val, c.ShouldEqual, 1)
		c.So(m.Get("none"), c.ShouldBeNil)
		m["none"] = 1
		val = m.GetDef("none", 2).(int)

		c.So(val, c.ShouldEqual, 1)
		c.So(m.Get("none"), c.ShouldEqual, 1)
		delete(m, "none")
		c.So(m.Get("none"), c.ShouldBeNil)

		m["none"] = 3
		c.So(m.Get("none"), c.ShouldEqual, 3)
		m.Del("none")
		c.So(m.Get("none"), c.ShouldBeNil)

		m.Set("none", 4)
		c.So(m.Get("none"), c.ShouldEqual, 4)
	})
}

func BenchmarkPyMap(b *testing.B) {
	m := cooltypes.NewPyMap()
	b.ResetTimer()
	for i := 0; i < b.N; i++ {
		m.Set("counter", m.GetDef("counter", 0).(int)+1)
	}
}

func BenchmarkMap(b *testing.B) {
	m := make(map[string]int)
	b.ResetTimer()
	for i := 0; i < b.N; i++ {
		val, exists := m["counter"]
		if exists {
			m["counter"] = val + 1
		} else {
			m["counter"] = 0
		}
	}
}
