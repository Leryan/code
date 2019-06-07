package atelier2

// Reader provides a row-based reader, like CSV, SQL…
type Reader interface {
	// Columns returns the number of columns in the reader.
	Columns() int
	// Headers returns the names of each column.
	Headers() []string
	// Next makes the "read cursor" go forward and return one row each time.
	// It must return io.EOF when there is nothing to read.
	Next() ([]string, error)
	// Close any internal stuff that's left opened.
	Close() error
}

// Writer reads from Reader and writes data to whatever "storage" it has.
type Writer interface {
	// From reader, read data and write them all.
	From(reader Reader) error
	// Close any internal stuff that's left opened.
	Close() error
}

func columnToInterface(cols []string) []interface{} {
	columns := make([]interface{}, len(cols), len(cols))
	for i, col := range cols {
		columns[i] = col
	}
	return columns
}
