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

type doMother int

func (d doMother) Do(ctx context.Context, r *ratatouille.Stuff) (*ratatouille.Mother, error) {
	return &ratatouille.Mother{
		Msg: "doing " + r.Stuff,
	}, nil
}

func (d doMother) Unicorn(ctx context.Context, r *empty.Empty) (*ratatouille.Derp, error) {
	return &ratatouille.Derp{
		Name: "Derpi",
	}, nil
}

func NewMother() ratatouille.MotherServiceServer {
	return doMother(0)
}

type doSon int

func (d doSon) Do(ctx context.Context, r *ratatouille.Stuff) (*ratatouille.Son, error) {
	time.Sleep(time.Millisecond * 50)
	return &ratatouille.Son{
		Msg: "doing " + r.Stuff,
	}, nil
}

func (d doSon) Belch(context.Context, *empty.Empty) (*ratatouille.Loudness, error) {
	return &ratatouille.Loudness{
		Db: uint64(1000),
	}, nil
}

func NewSon() ratatouille.SonServiceServer {
	return doSon(0)
}

func main() {
	listener, err := net.Listen("tcp", addr)
	if err != nil {
		panic(err)
	}
	defer listener.Close()

	srv := grpc.NewServer()
	ratatouille.RegisterMotherServiceServer(srv, NewMother())
	ratatouille.RegisterSonServiceServer(srv, NewSon())

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

	son := ratatouille.NewSonServiceClient(client)
	mother := ratatouille.NewMotherServiceClient(client)

	go func() {
		for true {
			ctx, cancel := context.WithTimeout(context.Background(), time.Second)
			res, err := son.Do(ctx, &ratatouille.Stuff{Stuff: "wank"})
			log.Printf("son.Do - Second: %v -> %v", spew.Sdump(res), err)
			cancel()

			ctx, cancel = context.WithTimeout(context.Background(), time.Millisecond*10)
			res, err = son.Do(ctx, &ratatouille.Stuff{Stuff: "internet"})
			log.Printf("son.Do - Millisec: %v -> %v", spew.Sdump(res), err)
			cancel()

			ctx, cancel = context.WithTimeout(context.Background(), time.Second)
			loudness, err := son.Belch(ctx, &empty.Empty{})
			log.Printf("son.DoSon - Second: %v -> %v", spew.Sdump(loudness), err)

			cancel()

			time.Sleep(time.Millisecond * 100)
		}
	}()

	go func() {
		for true {
			ctx, cancel := context.WithTimeout(context.Background(), time.Second*2)
			res, err := mother.Do(ctx, &ratatouille.Stuff{Stuff: "yell"})
			log.Printf("mother.Do: %v -> %v", spew.Sdump(res), err)

			unicorn, err := mother.Unicorn(ctx, &empty.Empty{})
			log.Printf("mother.Unicorn: %v -> %v", spew.Sdump(unicorn), err)

			cancel()

			time.Sleep(time.Millisecond * 100)
		}
	}()

	<-stop
	time.Sleep(time.Millisecond * 10)

}
