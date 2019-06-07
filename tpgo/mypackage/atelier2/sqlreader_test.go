package atelier2_test

import (
	"io"
	"mypackage/atelier2"
	"testing"
)

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

func BenchmarkSQLReaderHeaders(b *testing.B) {
	writer, err := atelier2.NewSQLWriter("testing.db")
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
