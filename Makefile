chapters = $(shell cat chapters)

all: index.html

index.html: ${chapters} chapters render.pl footer.html header.html
	cat chapters | xargs ./render.pl | cat header.html - footer.html > $@
