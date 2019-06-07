package atelier2

type Reader interface {
	Columns() int
	Headers() []string
	Next() ([]string, error)
	Close() error
}

type Writer interface {
	From(reader Reader) error
	Close() error
}

func columnToInterface(cols []string) []interface{} {
	columns := make([]interface{}, len(cols), len(cols))
	for i, col := range cols {
		columns[i] = col
	}
	return columns
}
