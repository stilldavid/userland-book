#!/usr/bin/env bash

# yes this should be a Makefile shouldn't it

cat chapters | xargs perl ./render.pl | cat header.html - footer.html > index.html
