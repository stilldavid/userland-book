slides = $(shell cat slides)

all: index.html

index.html: ${slides} footer.html header.html slides.css ./render.pl
	cat slides | xargs ./render.pl | cat header.html - footer.html > $@
