#!/bin/sh
go build . && ./runner -rules ../compiler/rules.so
