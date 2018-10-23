package main

import (
	"bufio"
	"bytes"
	"fmt"
	"io"
	"os"
	"runtime/pprof"
	"strings"
)

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

type myParser struct {
	source     io.Reader
	rbuf       []byte
	tagStarted bool
	tagClosing bool
	tagCurrent []byte
	s          uint64
	tok        mpToken
	acc        []byte
	rn         int
	irn        int
	rbufferr   error
	blchar     bool
	lchar      byte
	lrerr      error
}

func c(S uint64) bool {
	return S > 0
}

func (p *myParser) read() {
	rn, err := p.source.Read(p.rbuf)
	p.rn = rn - 1
	p.lrerr = err
}

func (p *myParser) parse() bool {
	var b byte
	for p.irn < p.rn {
		p.irn++
		if !p.blchar {
			b = p.rbuf[p.irn-1]
		} else {
			b = p.lchar
			p.blchar = false
			p.irn--
		}
		if b == '<' {
			if c(p.s & NONE) {
				if p.rbuf[p.irn] != '/' {
					p.s = START_TAG_IN
					p.acc = make([]byte, 0)
				}
			} else if c(p.s & DATA) {
				if p.rbuf[p.irn] == '/' {
					p.s = END_TAG_IN
					p.tok.SetData(p.acc)
					return true
				}
				p.s = START_TAG_IN
				p.acc = make([]byte, 0)
			}
		} else if b == '>' {
			if c(p.s & START_TAG_IN) {
				p.s = DATA
				p.tok.SetTagName(p.acc)
				p.acc = make([]byte, 0)
			} else if c(p.s & END_TAG_IN) {
				p.s = NONE
			}
		} else if c(p.s&DATA | p.s&START_TAG_IN) {
			p.acc = append(p.acc, b)
		}
	}

	p.irn = 0
	p.lchar = p.rbuf[len(p.rbuf)-1]
	p.blchar = true
	return false
}

func (p *myParser) Parse() (mpToken, error) {
	for {
		if p.parse() {
			return p.tok, nil
		}
		if p.lrerr == io.EOF {
			return p.tok, p.lrerr
		}
		p.read()
	}
}

func newMyParser(reader io.Reader) (*myParser, error) {
	p := myParser{
		source: reader,
		rbuf:   make([]byte, 8*1024),
		s:      NONE,
	}
	p.read()
	return &p, p.lrerr
}

func goMyParser() {
	fmt.Println("Go SAX MyParser")
	f, _ := os.Open("sitemap.xml")
	r := bufio.NewReader(f)
	p, _ := newMyParser(r)
	locs := make([][]byte, 0)
	tag := []byte("loc")

	for {
		t, err := p.Parse()
		if err != nil && err != io.EOF {
			fmt.Printf("err: %v", err)
			break
		}
		if err == io.EOF {
			break
		}
		if bytes.Compare(t.TagName, tag) == 0 {
			locs = append(locs, t.Data)
		}
	}
	fmt.Println(strings.TrimSpace(string(locs[len(locs)-1])))
}

func main() {
	cpuprof, _ := os.Create("cpuprof")
	pprof.StartCPUProfile(cpuprof)
	defer pprof.StopCPUProfile()
	goMyParser()
}
