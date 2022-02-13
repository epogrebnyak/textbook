dir := "bibs"

collect:
  cat {{dir}}/*.bib > books.bib
  cat books.bib
  cp books.bib book/references.bib
  cp books.bib paper/paper.bib

build:
  jupyter-book build book/  

book label:
  ./makebib.sh books.toml {{label}} -D {{dir}}
  cat {{dir}}/{{label}}.bib

