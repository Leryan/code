package atelier2

import (
	"database/sql"
	"io"
)

type sqlreader struct {
	db     *sql.DB
	cursor *sql.Rows
}

func NewSQLReader(dbpath string) (Reader, error) {
	db, err := sql.Open("sqlite3", dbpath)
	return &sqlreader{db: db}, err
}

func (s *sqlreader) Close() error {
	return s.db.Close()
}

func (s *sqlreader) Columns() int {
	return len(s.Headers())
}

func (s *sqlreader) Headers() []string {
	r, err := s.db.Query("pragma table_info(example)")
	if err != nil {
		panic(err)
	}
	headers := make([]string, 0)

	var n1, n2, n3, n4, n5, n6 interface{} // alloc only once
	for r.Next() {
		err := r.Scan(&n1, &n2, &n3, &n4, &n5, &n6)
		if err != nil {
			panic(err)
		}
		headers = append(headers, string(n2.([]uint8)))
	}
	return headers
}

func (s *sqlreader) Next() ([]string, error) {
	if s.cursor == nil {
		r, err := s.db.Query("select * from example")
		if err != nil {
			return nil, err
		}
		s.cursor = r
	}
	if s.cursor.Next() {
		var o1, o2, o3 string
		if err := s.cursor.Scan(&o1, &o2, &o3); err != nil {
			return nil, err
		}
		columns := []string{o1, o2, o3}
		return columns, nil
	}
	s.cursor.Close()
	s.cursor = nil
	return nil, io.EOF
}
