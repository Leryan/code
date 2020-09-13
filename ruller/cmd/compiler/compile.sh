#!/bin/sh
go build . && ./compiler -output $HOME/rules.go && go build -buildmode=plugin ~/rules.go
