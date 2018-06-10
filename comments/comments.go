package main

import (
	"database/sql"
	"encoding/json"
	"errors"
)

// Comment struct
type Comment struct {
	ID        int        `json:"id"`
	URI       string     `json:"uri"`
	Comment   string     `json:"comment"`
	Author    string     `json:"author"`
	CreateTS  int        `json:"create_ts"`
	Hidden    bool       `json:"hidden"`
	Replies   []*Comment `json:"replies"`
	RepliesTo *int       `json:"-"`
}

// AddReply adds a comment as reply if com.RepliesTo == comment.ID
func (comment *Comment) AddReply(com *Comment) error {
	if com == nil {
		return errors.New("not a reply to comment")
	}
	if com.RepliesTo == nil {
		return errors.New("not a reply to comment")
	}
	if *com.RepliesTo != comment.ID {
		return errors.New("not a reply to comment")
	}

	comment.Replies = append(comment.Replies, com)

	return nil
}

// Fill fields of given Comment from sql row
func (comment *Comment) Fill(rows *sql.Rows) error {
	err := rows.Scan(
		&comment.ID,
		&comment.CreateTS,
		&comment.URI,
		&comment.Author,
		&comment.Comment,
		&comment.Hidden,
		&comment.RepliesTo,
	)

	return err
}

// FillReplies of comment from all comments
func (comment *Comment) FillReplies(comments *[]Comment) error {
	if comments == nil {
		return nil
	}

	for _, com := range *comments {
		comment.AddReply(&com)
	}

	return nil
}

func (comment *Comment) ToJSON() (string, error) {
	jdoc, err := json.Marshal(comment)
	if err != nil {
		return "", err
	}
	return string(jdoc), nil
}

func (db *DB) getComments(comments *[]Comment) error {
	var err error
	var rows *sql.Rows
	var query string

	query = "select id, create_ts, uri, author, comment, hidden, replies_to from comments"
	if rows, err = db.Query(query); err != nil {
		return err
	}

	defer rows.Close()

	for rows.Next() {
		var c Comment
		if err = c.Fill(rows); err != nil {
			return err
		}
		*comments = append(*comments, c)
	}
	return nil
}

func (db *DB) getCommentsByURI(comments *[]Comment, uri string) error {
	var err error
	var rows *sql.Rows
	var query string

	query = "select id, create_ts, uri, author, comment, hidden, replies_to from comments where uri = ?"

	if rows, err = db.Query(query, uri); err != nil {
		return err
	}

	defer rows.Close()

	for rows.Next() {
		var c Comment
		if err = c.Fill(rows); err != nil {
			return err
		}
		*comments = append(*comments, c)
	}
	return nil
}
