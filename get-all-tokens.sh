#!/usr/bin/env bash

# get every name that looks like a Procedure, Table or View
# assumed length of schema name is 6+

schemaNameMinLength=6
objectRegex='[PTV]_'

tokenFile='tokens-all.txt'

> $tokenFile

for f in $(find Proc Table View -type f)
do
	tokenize.pl < $f 
done | sort -u |  grep -E "[A-Z_]{${schemaNameMinLength},}\.${objectRegex}" | tr -d '[;()]"--"' > $tokenFile



