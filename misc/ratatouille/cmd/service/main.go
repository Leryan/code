package main

import (
	"context"
	"github.com/davecgh/go-spew/spew"
	"github.com/golang/protobuf/ptypes/empty"
	"google.golang.org/grpc"
	"log"
	"net"
	"os"
	"os/signal"
	"ratatouille/internal/grpc/ratatouille"
	"syscall"
	"time"
)

const addr = "localhost:6000"

type doMother struct{}

func (d doMother) Do(ctx context.Context, r *empty.Empty) (*ratatouille.Mother, error) {
	return &ratatouille.Mother{
		Msg: "mother",
	}, nil
}

func (d doMother) DoMother(ctx context.Context, r *empty.Empty) (*ratatouille.Mother, error) {
	return &ratatouille.Mother{
		Msg: "DoMother",
	}, nil
}

func NewMother() ratatouille.DoMotherServer {
	return &doMother{}
}

type doSon struct{}

func (d doSon) Do(ctx context.Context, mother *ratatouille.Mother) (*ratatouille.Son, error) {
	time.Sleep(time.Millisecond * 50)
	return &ratatouille.Son{
		Msg: mother.Msg,
	}, nil
}

func (d doSon) DoSon(context.Context, *empty.Empty) (*ratatouille.Son, error) {
	return &ratatouille.Son{
		Msg: "DoSon",
	}, nil
}

func NewSon() ratatouille.DoSonServer {
	return &doSon{}
}

func main() {
	listener, err := net.Listen("tcp", addr)
	if err != nil {
		panic(err)
	}
	defer listener.Close()

	srv := grpc.NewServer()
	ratatouille.RegisterDoMotherServer(srv, NewMother())
	ratatouille.RegisterDoSonServer(srv, NewSon())

	signals := make(chan os.Signal, 1)
	signal.Notify(signals, syscall.SIGINT, syscall.SIGTERM)

	go func() {
		log.Printf("err: %v", srv.Serve(listener))
	}()
	defer srv.GracefulStop()

	client, err := grpc.Dial(addr, grpc.WithInsecure())
	if err != nil {
		panic(err)
	}

	stop := make(chan bool, 1)

	go func() {
		<-signals
		log.Printf("stopping gracefuly")
		client.Close()
		srv.GracefulStop()
		listener.Close()
		stop <- true
	}()

	son := ratatouille.NewDoSonClient(client)
	mother := ratatouille.NewDoMotherClient(client)

	go func() {
		for true {
			ctx, cancel := context.WithTimeout(context.Background(), time.Second)
			res, err := son.Do(ctx, &ratatouille.Mother{Msg: "from son client"})
			log.Printf("son.Do - Second: %v -> %v", spew.Sdump(res), err)
			cancel()

			ctx, cancel = context.WithTimeout(context.Background(), time.Millisecond*10)
			res, err = son.Do(ctx, &ratatouille.Mother{Msg: "from son client"})
			log.Printf("son.Do - Millisec: %v -> %v", spew.Sdump(res), err)
			cancel()

			ctx, cancel = context.WithTimeout(context.Background(), time.Second)
			res, err = son.DoSon(ctx, &empty.Empty{})
			log.Printf("son.DoSon - Second: %v -> %v", spew.Sdump(res), err)

			cancel()

			time.Sleep(time.Millisecond * 100)
		}
	}()

	go func() {
		for true {
			ctx, cancel := context.WithTimeout(context.Background(), time.Second*2)
			res, err := mother.Do(ctx, &empty.Empty{})
			log.Printf("mother: %v -> %v", spew.Sdump(res), err)

			res, err = mother.DoMother(ctx, &empty.Empty{})
			log.Printf("mother: %v -> %v", spew.Sdump(res), err)

			cancel()

			time.Sleep(time.Millisecond * 100)
		}
	}()

	<-stop
	time.Sleep(time.Millisecond * 10)

}
