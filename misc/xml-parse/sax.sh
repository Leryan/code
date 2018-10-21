#!/usr/bin/env bash
set -e
set -o pipefail

go build -o saxparser-go saxparser.go

cd saxparser-rust && cargo build --release
cd ..

time python saxparser.py
time ./saxparser-go
time python saxparser-lxml.py
time saxparser-rust/target/release/saxparser
