package main

import (
	"database/sql"
	"encoding/json"
	"github.com/gorilla/mux"
	"log"
	"net/http"
)

type DB struct {
	*sql.DB
}

type DataModel interface {
	getCommentsByURI(comments *[]Comment, uri string) error
	getComments(comments *[]Comment) error
}

// Env global environment: db connection...
type Env struct {
	db DataModel
}

func linkComments(comments []Comment) (map[int]*Comment, error) {
	commap := make(map[int]*Comment)

	for i := range comments {
		comid := comments[i].ID
		commap[comid] = &comments[i]
	}

	for i := range comments {
		replies_to := comments[i].RepliesTo
		if replies_to != nil {
			comrep := commap[*replies_to]
			comrep.AddReply(&comments[i])
		}
	}

	return commap, nil
}

func (env *Env) getCommentsByURI(w http.ResponseWriter, r *http.Request) {
	var uri = mux.Vars(r)["uri"]
	var comments []Comment
	if err := env.db.getCommentsByURI(&comments, uri); err != nil {
		log.Print(err)
		return
	}

	_, err := linkComments(comments)
	if err != nil {
		log.Print(err)
		return
	}

	jdoc, err := json.Marshal(comments)
	if err != nil {
		w.Write([]byte("error"))
		return
	}

	w.Write(jdoc)

}

func (env *Env) getComments(w http.ResponseWriter, r *http.Request) {
	var comments []Comment
	if err := env.db.getComments(&comments); err != nil {
		log.Print(err)
	}

	commap, err := linkComments(comments)
	if err != nil {
		log.Print(err)
	}

	log.Print(comments)
	log.Print(commap)

	w.Write([]byte("comments"))
}
