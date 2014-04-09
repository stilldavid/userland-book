#!/usr/bin/env bash

# yes this should be a Makefile shouldn't it

perl ./render.pl ./index.md ./literary_environment/index.md ./literary_problem/index.md ./programmerthink/index.md ./diff/index.md ./programs/index.md ./further_reading/index.md ./links.md | cat header.html - footer.html > index.html
