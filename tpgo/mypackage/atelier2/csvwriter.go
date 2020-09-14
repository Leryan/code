package atelier2

import (
	"encoding/csv"
	"os"
)

type csvwriter struct {
	fh *os.File
	w  *csv.Writer
}

// NewCSVWriter writes with "," separator
func NewCSVWriter(path string) (Writer, error) {
	fh, err := os.Create(path)
	return &csvwriter{
		w:  csv.NewWriter(fh),
		fh: fh,
	}, err
}

func (c *csvwriter) From(reader Reader) error {
	defer c.w.Flush()
	c.w.Write(reader.Headers())
	for {
		crow, err := reader.Next()
		if err != nil {
			return err
		}
		err = c.w.Write(crow)
		if err != nil {
			return err
		}
	}
}

func (c *csvwriter) Close() error {
	c.w.Flush()
	return c.fh.Close()
}
