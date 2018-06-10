package main

import (
	"database/sql"
	"github.com/gorilla/mux"
	_ "github.com/mattn/go-sqlite3"
	"io/ioutil"
	"log"
	"net/http"
	"os"
)

func main() {
	var setupSQL []byte
	var dbconn *sql.DB
	var err error

	os.Remove("comments.db")

	if dbconn, err = sql.Open("sqlite3", "comments.db"); err != nil {
		log.Fatal(err)
	}

	log.Print("initialising database...")
	if setupSQL, err = ioutil.ReadFile("setup.sql"); err != nil {
		log.Fatal(err)
	}
	_, err = dbconn.Exec(string(setupSQL))
	if err != nil {
		log.Fatal(err)
	}

	log.Print("done.")

	var env = Env{&DB{dbconn}}
	var router = mux.NewRouter()

	router.HandleFunc("/comments", env.getComments)
	router.HandleFunc("/comments/{uri:[a-zA-Z0-9_\\-\\.]+}", env.getCommentsByURI)
	http.Handle("/", router)
	http.ListenAndServe(":8080", nil)

}
