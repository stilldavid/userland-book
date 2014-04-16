4. programs + programmering
===========================

Back in chapter 1, I said that "the way you use the computer is often just to write
little programs that invoke other programs".  In fact, we've already gone over a
bunch of these.  Grepping through the text of a previous chapter should pull
up some good examples:

<!-- exec -->

    $ grep -E '[a-z]+.*\| ' ../literary_environment/index.md
        $ sort -k2 authors_* | uniq
        $ sort colors | uniq -i -c
        $ sort authors_* | uniq > all_authors
    thing as `cat all_authors | nl`, or `nl all_authors`.  You won't see this as
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
trying to figure something out - but what about when you've already figured it out and
you want to repeat it in the future?

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

It's worth the time it takes to learn one of the serious editors, but there are
easier places to start.  Nano, for example, is easy to pick up, and should be
available on most systems.  To start it, just say:

    $ nano file

You should see something like this:

{nano.png}

Arrow keys will move your cursor around, and typing stuff will make it appear
in the file.  This is pretty much like every other editor you've ever used.  If
you haven't used Nano before, that stuff along the bottom of the terminal is a
reference to the most commonly used commands.  `^` is a convention for "Ctrl",
so `^O` means Ctrl-o (the case of the letter doesn't actually matter), which
will save the file you're working on.  Ctrl-x will quit, which is probably the
first important thing to know about any given editor.

scripting
---------

So back to putting commands in text files.  

<!-- exec -->

    $ cat lspoems
    #!/bin/bash
    
    # a script to find poems marked as good
    find ~/p1k3/archives -name 'meta-ok-poem' | xargs dirname

<!-- end -->

<!-- exec -->

    $ ./lspoems
    /home/brennen/p1k3/archives/2013/2/9/meta-ok-poem

<!-- end -->
