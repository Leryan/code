package main

import (
	"fmt"
	"io"
	"mypackage/atelier2"
)

func mpanic(err error) {
	if err != nil && err != io.EOF {
		panic(err)
	}
}

func atelier1() {
	hg := Point{0, 5}
	hd := Point{10, 5}
	bg := Point{0, 0}
	bd := Point{10, 0}
	rectangle := NewRectangle(hg, hd, bg, bd)
	fmt.Println(rectangle.Air())

	rekt := make([]Rectangle, 4)
	rekt[0] = rectangle

	for i, rect := range rekt {
		fmt.Printf("%d: %f\n", i, rect.Air())
	}
}

func mainatelier2() {
	csvr, err := atelier2.NewCSVReader("example.csv")
	mpanic(err)
	sqlw, err := atelier2.NewSQLWriter("db.sqlite")
	mpanic(err)
	defer sqlw.Close()
	mpanic(sqlw.From(csvr))

	//

	sqlr, err := atelier2.NewSQLReader("db.sqlite")
	mpanic(err)
	csvw, err := atelier2.NewCSVWriter("example.out.csv")
	mpanic(err)
	defer csvw.Close()
	mpanic(csvw.From(sqlr))
}

func atelier3() {
	Game()
}

type geometry interface {
	area() float64
}

type rectangle struct {
	width  float64
	height float64
}

func (r rectangle) area() float64 {
	return r.height * r.width
}

func compute(v interface{}) {
	switch stuff := v.(type) {
	case geometry:
		fmt.Println(stuff.area())
	case int:
		fmt.Printf("int: %d", stuff)
	}
}

func dostuff(a, b interface{}) (int, error) {
	return 1, nil
}
func main() {
	atelier3()
}
