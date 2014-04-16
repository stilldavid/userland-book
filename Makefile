chapters = $(shell cat chapters)

all: index.html

index.html: ${chapters} chapters
	cat chapters | xargs perl ./render.pl | cat header.html - footer.html > $@
