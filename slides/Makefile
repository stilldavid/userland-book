all: index.html

index.html: *.md footer.html header.html slides.css ./render.pl
	ls *.md | sort -n | xargs ./render.pl | cat header.html - footer.html > $@
