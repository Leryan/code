package atelier2

import (
	"encoding/csv"
	"os"
)

type csvreader struct {
	reader  *csv.Reader
	headers []string
	fh      *os.File
}

// NewCSVReader reads CSV with ";" separator
func NewCSVReader(path string) (Reader, error) {
	fh, err := os.Open(path)
	if err != nil {
		return nil, err
	}
	cr := csvreader{
		reader:  csv.NewReader(fh),
		headers: make([]string, 0),
		fh:      fh,
	}
	return &cr, cr.preload()
}

func (c *csvreader) Close() error {
	return c.fh.Close()
}

func (c *csvreader) preload() error {
	c.reader.Comma = ';'
	headers, err := c.reader.Read()
	c.headers = headers
	return err
}

func (c *csvreader) Headers() []string {
	return c.headers
}

func (c *csvreader) Columns() int {
	return len(c.headers)
}

func (c *csvreader) Next() ([]string, error) {
	return c.reader.Read()
}
