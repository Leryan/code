package main

import (
	"bufio"
	"bytes"
	"fmt"
	"io"
	"os"
	"strings"
)

type myParser struct {
	source     io.Reader
	rbuf       []byte
	tagStarted bool
	tagClosing bool
	tagCurrent []byte
}

type mpToken struct {
	Data    []byte
	TagName []byte
}

func (t *mpToken) SetData(bytes []byte) {
	t.Data = make([]byte, len(bytes))
	copy(t.Data, bytes)
}

func (t *mpToken) SetTagName(bytes []byte) {
	t.TagName = make([]byte, len(bytes))
	copy(t.TagName, bytes)
}

const (
	NONE          = uint64(1)
	START_TAG_IN  = uint64(2)
	DATA          = uint64(8)
	END_TAG_START = uint64(16)
	END_TAG_IN    = uint64(32)
	END_TAG_END   = uint64(64)
)

func (p *myParser) Parse(stream chan mpToken) error {
	tok := mpToken{}

	p.rbuf = make([]byte, 20*1024*1024)
	acc := make([]byte, 0)

	s := NONE

	c := func(S uint64) bool {
		return S > 0
	}

	for {
		rn, err := p.source.Read(p.rbuf)
		irn := 0
		for irn < rn-1 {
			b := p.rbuf[irn]

			if b == '<' {
				if c(s & NONE) {
					if p.rbuf[irn+1] != '/' {
						s = START_TAG_IN
						acc = make([]byte, 0)
					}
				} else if c(s & DATA) {
					if p.rbuf[irn+1] == '/' {
						s = END_TAG_IN
						tok.SetData(acc)
						stream <- tok
					} else {
						s = START_TAG_IN
						acc = make([]byte, 0)
					}
				}
			} else if b == '>' {
				if c(s & START_TAG_IN) {
					s = DATA
					tok.SetTagName(acc)
					acc = make([]byte, 0)
				} else if c(s & END_TAG_IN) {
					s = NONE
				}
			} else if c(s&DATA | s&START_TAG_IN) {
				acc = append(acc, b)
			}

			irn++
		}

		if err != nil {
			return err
		}
	}
}

func newMyParser(reader io.Reader) *myParser {
	return &myParser{
		source: reader,
		rbuf:   make([]byte, 8192),
	}
}

func goMyParser() {
	fmt.Println("Go SAX MyParser")
	f, _ := os.Open("sitemap.xml")
	r := bufio.NewReader(f)
	p := newMyParser(r)
	ch := make(chan mpToken)
	tag := []byte("loc")
	locs := make([][]byte, 0)

	go func() {
		err := p.Parse(ch)
		if err != nil && err != io.EOF {
			fmt.Printf("err: %v", err)
		}
		close(ch)
	}()

	for t := range ch {
		if bytes.Compare(t.TagName, tag) == 0 {
			locs = append(locs, t.Data)
		}
	}

	fmt.Println(strings.TrimSpace(string(locs[len(locs)-1])))
}

func main() {
	goMyParser()
}
