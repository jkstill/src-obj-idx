#!/usr/bin/env bash

# show all files that include an object 
# ./find-obj.sh SCHEMA.NAME

declare DEBUG=0

isDebugEnabled () {
	if [[ $DEBUG -eq 0 ]]; then
		return 1
	else
		return 0
	fi
}

setDebugPrefix () {
	local desiredPrefix=$1

	if isDebugEnabled; then
		echo -n "${desiredPrefix}:"
	fi
}

usage () {
	cat << -EOF

usage: $0 search-term search-level

the default search level is 3

-EOF
}


declare idxFile='schema-index.txt'
declare searchTerm=$1
declare maxLevel=$2

set -u

[[ -z $searchTerm ]] && {
	usage
	exit 1
}

# max level 4 may go too deep - finds dependents of dependents, ...
# sometimes level 4 is necessary though - try 4, and if too much, then 3
: ${maxLevel:=3}

set GREP_COLORS='mt=0;30;42'

# object|file

for object in $(grep -E ":${searchTerm}$|${searchTerm}:" $idxFile | cut -f2 -d: | sort -u)
do

	prefix=$(setDebugPrefix 1)
	echo ${prefix}'object:'${object}

	if [[ $maxLevel -gt 1 ]]; then
		for file in $(grep -E ":${searchTerm}$|${searchTerm}:" $idxFile | cut -f1 -d: | sort -u)
		do
			prefix=$(setDebugPrefix 2)
			echo ${prefix}'file:'${file}

			if [[ $maxLevel -gt 2 ]]; then

				for object in $(grep -E ":${file}$|${file}:" $idxFile | cut -f2 -d: | sort -u)
				do
					prefix=$(setDebugPrefix 3)
					echo ${prefix}'object:'${object}
					
					if [[ $maxLevel -gt 3 ]]; then
						for file in $(grep -E ":${object}$|${object}:" $idxFile | cut -f1 -d: | sort -u)
						do
							prefix=$(setDebugPrefix 4)
							echo ${prefix}'file:'${file}
						done
					fi # #maxlevel GT 4
				done

			fi # maxlevel GT 2

		done

	fi # maxlevel GT 1

done | sort -u



