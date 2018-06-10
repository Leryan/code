package main

import (
	"encoding/json"
	"testing"
)

func TestCommentJSON(t *testing.T) {
	RepID0 := 0
	comment := Comment{
		Author:   "test",
		Comment:  "test",
		CreateTS: 0,
		Hidden:   false,
		ID:       0,
	}
	commentR := Comment{
		Author:    "test2",
		Comment:   "test2",
		CreateTS:  1,
		Hidden:    false,
		ID:        1,
		RepliesTo: &RepID0,
	}
	comment.AddReply(&commentR)
	_, err := json.Marshal(comment)
	if err != nil {
		t.Error("error")
	}

}

func TestCommentReplies(t *testing.T) {
	RepliesTo0 := 0
	RepliesToBadID := 1000

	// Root comment
	comment := Comment{
		Author:   "test",
		Comment:  "test",
		CreateTS: 0,
		Hidden:   false,
		ID:       0,
	}

	// A Reply
	commentR := Comment{
		Author:    "test2",
		Comment:   "test2",
		Hidden:    false,
		ID:        1,
		RepliesTo: &RepliesTo0,
	}

	// Not a Reply
	commentNR := Comment{
		Author:  "test3",
		Comment: "test3",
		Hidden:  false,
		ID:      2,
	}

	// Not a Reply to comment
	commentNRC := Comment{
		Author:    "test4",
		Comment:   "test4",
		Hidden:    false,
		ID:        3,
		RepliesTo: &RepliesToBadID,
	}

	err := comment.AddReply(&commentR)

	if err != nil {
		t.Error("error returned")
	}

	err = comment.AddReply(&commentNRC)
	if err == nil {
		t.Error("no error returned ad not a reply to comment input")
	}

	if err = comment.AddReply(nil); err == nil {
		t.Error("no error returned at nil input")
	}

	comment.AddReply(&commentNR)

	if comment.Replies == nil {
		t.Error("ref not added")
	}

	if comment.Replies[0] != &commentR {
		t.Error("bad ref")
	}

	if len(comment.Replies) != 1 {
		t.Error("bad reply added")
	}

}
