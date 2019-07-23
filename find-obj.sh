#!/usr/bin/env bash


# show all files that include an object 
# ./find-obj.sh SCHEMA.NAME

idxFile='schema-index.txt'
searchTerm=$1

set -u

: ${searchTerm:?Please provide search term}

set GREP_COLORS='mt=0;30;42'

grep --color -E ":${searchTerm}$|/${searchTerm}:" $idxFile



