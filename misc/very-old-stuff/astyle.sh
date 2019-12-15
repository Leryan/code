#!/usr/bin/env sh
astyle --indent=spaces=4 --style=linux --indent-classes --indent-switches --indent-cases --indent-namespaces --indent-preprocessor --delete-empty-lines --break-blocks --pad-header --add-one-line-brackets --keep-one-line-blocks --keep-one-line-statements --pad-oper --convert-tabs --align-pointer=name --formatted --lineend=linux $*
