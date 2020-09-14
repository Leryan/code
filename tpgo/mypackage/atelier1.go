package main

import "math"

type Point struct {
	X float64
	Y float64
}

type Rectangle struct {
	HG Point
	HD Point
	BG Point
	BD Point
}

func (r Rectangle) Air() float64 {
	return distance(r.HG, r.HD) * distance(r.HG, r.BG)
}

func distance(a, b Point) float64 {
	return math.Sqrt(math.Pow(b.X-a.X, 2) + math.Pow(b.Y-a.Y, 2))
}

func NewRectangle(hg, hd, bg, bd Point) Rectangle {
	if distance(hg, hd) != distance(bg, bd) {
		panic("wrong distance")
	}
	if distance(hg, bg) != distance(hd, bd) {
		panic("wrong distance")
	}
	if hg.Y != hd.Y {
		panic("y not aligned")
	}
	if hg.X != bg.X {
		panic("x not aligned")
	}
	return Rectangle{HG: hg, HD: hd, BG: bg, BD: bd}
}
