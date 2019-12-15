package main

import (
	"fmt"
	"math/rand"
	"time"
)

type PlayType int

const (
	PLEFT PlayType = iota
	PRIGHT
	PMIDDLE
	PWIN
)

type Player struct {
	Points   int
	name     string
	ballRecv <-chan PlayType
	ballSend chan PlayType
	endgame  chan bool
}

func (p *Player) Service() {
	p.log("%s", "service")
	p.ballSend <- p.choose()
}

func (p *Player) choose() PlayType {
	pt := PMIDDLE
	r := rand.Intn(4)
	switch r {
	case 0:
		pt = PLEFT
	case 1:
		pt = PRIGHT
	case 2:
		pt = PMIDDLE
	case 3:
		pt = PWIN
	}
	return pt
}

func (p *Player) log(format string, args ...interface{}) {
	fmt.Printf("%s: ", p.name)
	fmt.Printf(format, args...)
	fmt.Printf("\n")
}

func (p *Player) Play() {
	for {
		select {
		case br := <-p.ballRecv:
			p.log("recv ball %d", br)
			pt := p.choose()
			d, _ := time.ParseDuration(fmt.Sprintf("%dms", rand.Intn(250)+500))
			if pt == PWIN {
				p.Points++
				p.log("POINT! (%d)", p.Points)
			}
			time.Sleep(d)
			p.log("send ball %d", pt)
			p.ballSend <- pt
			if p.Points > 9 {
				p.log("WIN!")
				p.endgame <- true
				p.endgame <- true
				return
			}
		case <-p.endgame:
			return
		}

	}
}

func NewPlayer(name string, incoming, outgoing chan PlayType, endgame chan bool) *Player {
	p := Player{
		name:     name,
		ballRecv: incoming,
		ballSend: outgoing,
		endgame:  endgame,
	}
	return &p
}

func Game() {
	p1p2 := make(chan PlayType)
	p2p1 := make(chan PlayType)
	endgame := make(chan bool)

	p1 := NewPlayer("jean valjean", p2p1, p1p2, endgame)
	p2 := NewPlayer("orni torinque", p1p2, p2p1, endgame)

	go p1.Play()
	go p2.Play()

	p1.Service()

	<-endgame

	fmt.Printf("P1: %d\n", p1.Points)
	fmt.Printf("P2: %d\n", p2.Points)

}
