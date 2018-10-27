package main

import (
	"bufio"
	"encoding/xml"
	"fmt"
	"io"
	"os"
	"runtime"
)

func main() {
	fmt.Println("Go SAX parsing")
	f, _ := os.Open("sitemap.xml")
	r := bufio.NewReader(f)
	d := xml.NewDecoder(r)
	data := make([][]byte, 0)

	for {
		t, err := d.Token()
		if err == io.EOF {
			break
		}

		switch tag := t.(type) {
		case xml.StartElement:
			if tag.Name.Space == "http://www.sitemaps.org/schemas/sitemap/0.9" && tag.Name.Local == "loc" {
				var s []byte
				if err := d.DecodeElement(&s, &tag); err != nil {
					fmt.Printf("error %v\n", err)
					continue
				}
				data = append(data, s)
			}
		}
	}

	var m runtime.MemStats
	runtime.ReadMemStats(&m)

	fmt.Printf("%v MiB, %d results\n", m.Alloc/1024/1024, len(data))
}
