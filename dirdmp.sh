#!/bin/bash
FILES=$1
OUT_DIR=$2
KEY_WORD=$3
OPTION=$4

replace(){
    path="${1}/*"
    for f in $path; do
	if [ -f "$f" ] && [[ $2 == 1 ]]; then
	    basename="${f##*/}"
	    newfile="${basename// /-}"
	    if [[ "$OPTION" == "-m" ]]; then
	       echo "Moving $f to ${OUT_DIR}/${newfile}"
	       mv "$f" ${OUT_DIR}/${newfile}
	    else
	       echo "Copying $f to ${OUT_DIR}/${newfile}"
	       cp "$f" ${OUT_DIR}/${newfile}
	    fi
	elif [ -d "$f" ]; then
	    if [[ "$f" == *"$KEY_WORD"* ]]; then
		echo "Entering **** $KEY_WORD **** dir $f..."
		replace $f 1 
	    else
		echo "Entering dir $f..."
		replace $f 0
	    fi
	fi
    done
    if [[ "$OPTION" == "-m" ]] && [[ $2 == 1 ]]; then
	echo "Deleting old **** $KEY_WORD **** dir $1"
	rmdir $1
    fi
}


replace $FILES 0



