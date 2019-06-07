package atelier2_test

import (
	"io"
	"mypackage/atelier2"
	"testing"

	. "github.com/smartystreets/goconvey/convey"
)

// testreader is a mocked atelier2.Reader
type testreader struct {
	rows    [][]string
	cursor  int
	headers []string
}

func (w *testreader) Columns() int {
	return len(w.headers)
}
func (w *testreader) Headers() []string {
	return w.headers
}

func (w *testreader) Next() ([]string, error) {
	if w.cursor < len(w.rows) {
		w.cursor++
		return w.rows[w.cursor-1], nil
	}
	w.cursor = 0
	return nil, io.EOF
}

func (w *testreader) Close() error {
	return nil
}

func newTestReader() atelier2.Reader {
	return &testreader{
		headers: []string{"coltest1", "coltest2", "coltest3"},
		rows:    [][]string{[]string{"val1", "val2", "val3"}, []string{"val4", "val5", "val6"}},
	}
}

// A test made with golang testing package.
func TestSQLReader(t *testing.T) {
	writer, err := atelier2.NewSQLWriter("testing.db")
	if err != nil {
		t.Fatal(err)
	}
	treader := newTestReader()
	if err := writer.From(treader); err != nil && err != io.EOF {
		t.Fatal(err)
	}

	reader, err := atelier2.NewSQLReader("testing.db")
	if err != nil {
		t.Fatal(err)
	}

	r, err := reader.Next()
	if err != nil {
		t.Fatal(err)
	}

	if r[0] != "val1" {
		t.Fatal("wrong value1")
	}
	if r[1] != "val2" {
		t.Fatal("wrong value2")
	}
	if r[2] != "val3" {
		t.Fatal("wrong value3")
	}

	r, err = reader.Next()
	if err != nil {
		t.Fatal(err)
	}

	if r[0] != "val4" {
		t.Fatal("wrong value4")
	}
	if r[1] != "val5" {
		t.Fatal("wrong value5")
	}
	if r[2] != "val6" {
		t.Fatal("wrong value6")
	}

	r, err = reader.Next()
	if r != nil {
		t.Fatal("should not return a value")
	}
	if err != io.EOF {
		t.Fatal("not eof")
	}
}

func TestSQLReaderWithConvey(t *testing.T) {
	Convey("setup test", t, func() {
		writer, err := atelier2.NewSQLWriter("testing.db")
		So(err, ShouldBeNil)
		So(writer, ShouldNotBeNil)

		treader := newTestReader()
		err = writer.From(treader)
		So(err, ShouldEqual, io.EOF)

		reader, err := atelier2.NewSQLReader("testing.db")
		So(err, ShouldBeNil)
		So(reader, ShouldNotBeNil)

		Convey("Headers should return column names", func() {
			headers := reader.Headers()
			So(headers, ShouldHaveLength, 3)
			So(headers[0], ShouldEqual, "coltest1")
			So(headers[1], ShouldEqual, "coltest2")
			So(headers[2], ShouldEqual, "coltest3")
		})

		Convey("Next #1 should return one line", func() {
			row, err := reader.Next()
			So(err, ShouldBeNil)
			So(row, ShouldHaveLength, 3)
			So(row[0], ShouldEqual, "val1")
			So(row[1], ShouldEqual, "val2")
			So(row[2], ShouldEqual, "val3")

			Convey("Next #2 should return one, different, line", func() {
				row, err := reader.Next()
				So(err, ShouldBeNil)
				So(row, ShouldHaveLength, 3)
				So(row[0], ShouldEqual, "val4")
				So(row[1], ShouldEqual, "val5")
				So(row[2], ShouldEqual, "val6")

				Convey("Next #3 should return no line and io.EOF", func() {
					row, err := reader.Next()
					So(err, ShouldEqual, io.EOF)
					So(row, ShouldBeNil)
				})
			})
		})
	})
}

func BenchmarkSQLReaderHeaders(b *testing.B) {
	writer, err := atelier2.NewSQLWriter("testing.db")
	if err != nil {
		b.Fatal(err)
	}
	if err := writer.From(newTestReader()); err != nil && err != io.EOF {
		b.Fatal(err)
	}
	reader, err := atelier2.NewSQLReader("testing.db")
	if err != nil {
		b.Fatal(err)
	}
	for i := 0; i < b.N; i++ {
		r := reader.Headers()
		b.StopTimer()
		if r[0] != "coltest1" {
			b.Fatal("bad column name")
		}
		b.StartTimer()
	}
}
