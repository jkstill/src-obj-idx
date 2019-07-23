#!/usr/bin/env bash

# get every name that looks like a Procedure, Table or View
# assumed length of schema name is 6+

schemaNameMinLength=5
objNameMinLength=2

indexFile='schema-index.txt'

> $tokenFile

for file in $(find Bteq Proc Table View -type f)
#for file in ./Bteq/STAGING/CUSTOMERS_PRE2STG.btq
do
	for word in $(tokenize.pl < $file)
	do
		echo $file:$word
	done
done | sort -u | grep  --binary-files=text -E ":[A-Za-z0-9_]{${schemaNameMinLength},}\.[[:alnum:]]{${objNameMinLength},}"  > $indexFile



