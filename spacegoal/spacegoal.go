/*
 * Florent Peterschmitt <florent@peterschmitt.fr>
 * MIT License
 * Have Fun.
 */

package main

import "fmt"
import "os"
import "strings"
import "encoding/json"
import "log"
import "errors"

import "github.com/jessevdk/go-flags"

type PrgmArgs struct {
	Mode      string `short:"M" long:"mode" description:"available modes: rpc" required:"true"`
	Url       string `short:"U" long:"url" description:"Spacewalk RPC API URL" required:"true"`
	Username  string `short:"u" long:"username" description:"Username"`
	Password  string `short:"p" long:"password" description:"Password"`
	SSLVerify bool   `short:"s" long:"sslverify" description:"SSLVerify"`
	Method    string `short:"m" long:"method" description:"Remote procedure name"`
	JsonArgs  string `short:"j" long:"json-args" description:"Procedure arguments as JSON document"`
	RPCOkCode int    `short:"o" long:"rpc-ok-code" description:"Program will return 0 even if the XML-RPC returned a fault of the given code" default:"0"`
}

func process_rpc_cli(args *PrgmArgs, l *log.Logger) (err error) {
	sp, err := NewSpacewalk(args.Url, args.SSLVerify)

	if err != nil {
		return err
	}

	err = sp.Login(args.Username, args.Password)
	if err != nil {
		return err
	}
	defer sp.Logout()

	var rpc_res interface{}
	var rpc_err error
	if args.JsonArgs != "" {
		var rpc_args []interface{}

		json_decoder := json.NewDecoder(strings.NewReader(args.JsonArgs))
		err = json_decoder.Decode(&rpc_args)
		if err != nil {
			return fmt.Errorf("json arguments error: %s", string(err.Error()))
		}

		rpc_err = sp.Call(args.Method, rpc_args, &rpc_res)
	} else {
		rpc_err = sp.Call(args.Method, nil, &rpc_res)
	}

	if rpc_err != nil {
		xerr, xperr := NewFault(rpc_err)

		err = rpc_err

		if xperr == nil {
			if xerr.Code == int64(args.RPCOkCode) {
				l.Println("skip error:", rpc_err)
				err = nil
			}
		}
	}

	if err != nil {
		return err
	}

	fmt.Println(rpc_res)

	return nil
}

func main() {
	var args PrgmArgs

	l := log.New(os.Stderr, "spacegoal: ", 0)

	_, err := flags.ParseArgs(&args, os.Args)
	if err != nil {
		os.Exit(1)
	}

	if args.Mode == "rpc" {
		err = process_rpc_cli(&args, l)
	} else {
		err = errors.New(fmt.Sprintf("Unsupported program mode '%s'", args.Mode))
	}

	if err != nil {
		l.Fatalln(err)
	}
}
