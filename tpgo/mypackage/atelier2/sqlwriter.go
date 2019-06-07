package atelier2

import (
	"database/sql"
	"fmt"
	"os"
	"strings"

	_ "github.com/mattn/go-sqlite3"
)

type sqlwriter struct {
	db *sql.DB
}

func (s *sqlwriter) From(reader Reader) error {
	s.setupTable(reader.Headers())

	for {
		col, err := reader.Next()
		if err != nil {
			return err
		}
		if err := s.addRow(columnToInterface(col)); err != nil {
			return err
		}
	}
}

func (s *sqlwriter) Close() error {
	return s.db.Close()
}

func (s *sqlwriter) setupTable(columns []string) error {
	ncols := make([]string, len(columns), len(columns))
	stmt := "create table example ("

	for i, col := range columns {
		ncols[i] = fmt.Sprintf("%s text", col)
	}

	stmt += strings.Join(ncols, ",")
	stmt += ");"

	_, err := s.db.Exec(stmt)
	return err
}

func (s *sqlwriter) addRow(columns []interface{}) error {
	stmt := "insert into example values ("
	for i := range columns {
		if i < len(columns)-1 {
			stmt += "?, "
		} else {
			stmt += "?"
		}
	}
	stmt += ")"
	_, err := s.db.Exec(stmt, columns...)
	return err
}

func NewSQLWriter(dbpath string) (Writer, error) {
	os.Remove(dbpath)
	db, err := sql.Open("sqlite3", dbpath)
	if err != nil {
		return nil, err
	}
	sw := sqlwriter{db: db}
	return &sw, nil
}
