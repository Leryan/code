package main

import "net/http"
import "crypto/tls"

//import "reflect"

import "github.com/kolo/xmlrpc"

type Spacewalk struct {
	Url       string
	User      string
	Password  string
	SSLVerify bool
	AuthKey   string
	Client    *xmlrpc.Client
}

// Create a new Spacewalk instance.
// Pass the full URL to the RPC API. Example: https://spacewalk/rpc/api/
// Bypass TLS checks for autosigned certificates.
func NewSpacewalk(url string, sslverify bool) (sp *Spacewalk, err error) {
	sp = new(Spacewalk)

	sp.Url = url
	sp.SSLVerify = sslverify

	tls_config := tls.Config{
		InsecureSkipVerify: !sp.SSLVerify,
	}

	transport := http.Transport{
		TLSClientConfig: &tls_config,
	}

	client, err := xmlrpc.NewClient(sp.Url, &transport)

	if err != nil {
		return nil, err
	}

	sp.Client = client

	return sp, nil
}

// Login to spacewalk with given user and password.
// An extra call to Login() will Logout() first, then authenticate.
func (sp *Spacewalk) Login(user string, password string) (err error) {
	sp.User = user
	sp.Password = password

	if sp.AuthKey != "" {
		sp.Logout()
	}

	login_args := []interface{}{sp.User, sp.Password}

	err = sp.Client.Call("auth.login", login_args, &sp.AuthKey)
	if err != nil {
		return err
	}

	return nil
}

// Call a remote method, passing the AuthKey automatically after being logged-in.
// Pass an interface{} slice with any arguments you want to pass, or nil if none.
// Pass an interface{} struct to store results.
func (sp *Spacewalk) Call(method string, arguments []interface{}, results interface{}) (err error) {
	arguments = append([]interface{}{sp.AuthKey}, arguments...)

	err = sp.Client.Call(method, arguments, results)

	return err
}

// Logout the user with the given AuthKey, then destroy the AuthKey.
func (sp *Spacewalk) Logout() (result int, err error) {
	err = sp.Call("auth.logout", nil, &result)

	sp.AuthKey = ""

	return result, err
}
