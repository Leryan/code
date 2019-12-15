#!/usr/bin/env sh

find . \( -name "*.c" -o -name "*.h" \) -exec dos2unix -U -v {} \;
find . \( -name "*.c" -o -name "*.h" \) -exec indent {} \;
find . \( -name "*.c" -o -name "*.h" \) -exec dos2unix -D -v {} \;
