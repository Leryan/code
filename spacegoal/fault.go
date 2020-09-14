package main

import "errors"
import "regexp"
import "strconv"

var errMsg = regexp.MustCompile(`^error: "(.*)" code: ([0-9]+)$`)

type Fault struct {
	Error string
	Code  int64
}

func NewFault(merr error) (xerr *Fault, err error) {
	matches := errMsg.FindStringSubmatch(string(merr.Error()))

	if len(matches) < 3 {
		return nil, errors.New("cannot parse given error")
	}

	m_error := matches[1]
	m_code, _ := strconv.ParseInt(matches[2], 10, 64)

	xerr = new(Fault)

	xerr.Error = m_error
	xerr.Code = m_code

	return xerr, nil
}
