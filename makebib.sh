#!/usr/bin/bash
if [[ $# -lt 1 ]] ; then
    echo Retrieve bibliographic information using TOML_FILE with books\' ISBN and labels.
    echo Usage:
    echo   ./makebib.sh TOML_FILE LABEL                Retrieve bibtex by LABEL 
    echo   ./makebib.sh TOML_FILE LABEL -D DIRECTORY   Save bibtex by LABEL to DIRECTORY
    echo   ./makebib.sh TOML_FILE -D DIRECTORY         Save all bibtex to DIRECTORY
    echo   ./makebib.sh TOML_FILE                      Print TOML_FILE
    exit 0    
fi

# Print TOML_FILE
if [ $# -eq 1 ] ; then
    tomlq 'keys[]' $1
    #tomlq .[].isbn $1
fi

# Retrieve bibtex for LABEL
if [ $# -eq 2 ] ; then
    tag="$2"
    tomlq .$tag.isbn $1 | xargs -I{} ./isbn.sh {} $tag 
fi

# Retrieve bibtex for LABEL and save to DIRECTORY
if [ $# -eq 4 ] && [ $3 = "-D" ] ; then
    tag="$2"
    dir="$4"
    tomlq .$tag.isbn $1 | xargs -I{} ./isbn.sh {} $tag > $dir/$tag.bib
fi

# Retrieve and save bibtex files for all labels 
if [ $# -eq 3 ]  && [ $2 = "-D" ]; then
    dir="$3"
    tomlq 'keys[]' $1 | xargs -I{} ./makebib.sh $1 {} -D $dir
    # cat $dir/*.bib > bibliography.bib
    # cat bibliography.bib
fi
