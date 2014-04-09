programs & programmering
========================

A bit ago, I said that "the way you use the computer is often just to write
little programs that invoke other programs".  In fact, we've already gone over a
bunch of these.  Grepping through the text of a previous chapter should pull
up some good examples:

<!-- exec -->

    $ grep -E '[a-z]+.*\| ' ../literary_environment/index.md
        $ sort -k2 authors_* | uniq
        $ sort colors | uniq -i -c
        $ sort authors_* | uniq > all_authors
        $ find ~/p1k3/archives/2010/11 -regextype egrep -regex '.*([0-9]+|index)' -type f | xargs wc -w | grep total
        $ sort authors_* | uniq | wc -l
        $ dict concatenate | head -10
        $ sort colors | uniq -i | tail -1
        $ cut -d' ' -f1 ./authors_* | sort | uniq -ci | sort -n | tail -3
        $ sort -u ./authors_* | cut -d' ' -f1 | uniq -ci | sort -n | tail -3
        $ cat ./authors_* | grep 'Vanessa'

<!-- end -->

None of these do all that much, but they all take input of one sort or another
and transform it into something new by doing a series of things to it.  They're
little formal sentences describing how to make one thing into another, which is
as good a definition of programming as most.  (Though it's true that a lot of
the programs we use day-to-day are more like essays or novels or interminable
Fantasy series where every character you like dies horribly than they are like
individual sentences.)

This kind of thing is all well and good when you're staring a terminal, trying
to figure something out - but what about when you've figured something out
and you want to repeat it in the future without remembering and typing a giant
string of weird characters all over again?

It turns out that Bash has you covered.  Since shell commands are just text,
they can live in a file as easily as they can be typed.
