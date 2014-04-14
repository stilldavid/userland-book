4. programs + programmering
===========================

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

None of these one-liners do all that much, but they all take input of one sort
or another and transform it into something new by doing a series of things to
it.  They're little formal sentences describing how to make one thing into
another, which is as good a definition of programming as most.  Or at least
this is a good way to describe programming-in-the-small.  (A lot of the
programs we use day-to-day are more like essays, novels, or interminable
Fantasy series where every character you like dies horribly than they are like
individual sentences.)

One-liners like these are all well and good when you're staring at a terminal,
trying to figure something out - but what about when you've figured it out and
you want to repeat it in the future without remembering and typing a giant
string of weird characters all over again?

It turns out that Bash has you covered.  Since shell commands are just text,
they can live in a text file as easily as they can be typed.

learn you an editor
-------------------

We've skirted the topic so far, but now that we're talking about writing out
text files in earnest, you're going to want a text editor.

My editor is where I spend most of my time that isn't in a web browser, because
it's where I write both code and prose.  It turns out that the features which
make a good code editor overlap a lot with the ones that make a good editor of
English sentences.

So what should you use?  Well, there have been other contenders in recent
years, but in truth nothing comes close to dethroning the Great Old Ones of
text editing.  Emacs is a creature both primal and sophisticated, like an
avatar of some interstellar civilization that evolved long before multicellular
life existed on earth and seeded the galaxy with incomprehensible artefacts and
colossal engineering projects.  Vim is like a lovable chainsaw-studded robot
with the most elegant keyboard interface in history secretly emblazoned on its
shining diamond heart.

It's worth the time it takes to learn one of the serious editors (there are few
things in the world of technology as likely to expand your abilities), but
there are easier places to start.  Nano, for example, is inoffensive and easy
to pick up, and should be available on most systems.

scripting
---------

So back to putting commands in text files.  Let's say I'm curious how many
words I've written so far in this book.  Since all of my chapters are in files
called `index.md`, I can always do something like the following:

<!-- exec -->

    $ find ../ -name 'index.md' | xargs wc -w
      753 ../programs/index.md
      224 ../further_reading/index.md
      893 ../literary_problem/index.md
     1990 ../programmerthink/index.md
      369 ../diff/index.md
     4233 ../literary_environment/index.md
      233 ../index.md
     8695 total

<!-- end -->

That's pretty easy to remember, but let's say I'm picky and want to see it in
the order the chapters are actually arranged.  I could pretty easily write a
file that lists them all, one-per line:

<!-- exec -->

    $ cat ../chapters
    ./index.md
    ./literary_environment/index.md
    ./literary_problem/index.md
    ./programmerthink/index.md
    ./programs/index.md
    ./diff/index.md
    ./further_reading/index.md
    ./links.md

<!-- end -->

...and then do something like:

 <!-- exec -->

    $ cd .. && xargs wc < chapters
       34   233  1399 ./index.md
      806  4233 26453 ./literary_environment/index.md
      150   893  5692 ./literary_problem/index.md
      264  1990 11776 ./programmerthink/index.md
      126   753  4797 ./programs/index.md
       37   369  2107 ./diff/index.md
       38   224  1664 ./further_reading/index.md
        1     2    20 ./links.md
     1456  8697 53908 total

<!-- end -->

(The `&&` means that if the first command succeeded, the shell go ahead and do
the second one.)


