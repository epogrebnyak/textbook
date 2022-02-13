#!/usr/bin/bash
if [[ $# -eq 0 ]] ; then
    echo 'Use ./isbn.sh ISBN LABEL to get bibtex info.'
    exit 0
fi

# Use manubot and pandoc to extract bibliographic information 
# about book in bibtex format.
if [[ $# -eq 1 ]] ; then
    manubot cite isbn:$1 | jq 'del(.[].note)' | pandoc -f csljson -t bibtex 
fi

# Create bibtex file with custom label.
if [[ $# -eq 2 ]] ; then
    manubot cite isbn:$1 | jq 'del(.[].note)' | jq '.[].id = "'$2'"' | pandoc -f csljson -t bibtex 
fi
