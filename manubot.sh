#!/usr/bin/bash
manubot cite $1 | jq 'del(.[].note)' | jq '.[].id = "'$2'"' | pandoc -f csljson -t bibtex 
