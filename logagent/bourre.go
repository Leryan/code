package main

import (
	"fmt"
	"net"
	"time"
)

func do(id int) {
	conn, err := net.Dial("tcp", "localhost:5959")
	if err != nil {
		panic(err)
	}
	fmt.Printf("ID %d\n", id)
	msg := []byte("{\"key\": \"data\", \"key2\": \"data2\", \"key3\": 100000, \"key5\": 10000000}\n")
	for {
		conn.Write(msg)
		time.Sleep(time.Millisecond * 50)
	}
}

func main() {
	forever := make(chan bool)
	for i := 0; i < 400; i++ {
		go do(i)
	}
	<-forever
}
