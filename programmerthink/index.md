programmerthink
===============

In the preceding chapter, I worked through accumulating a big piece of text
from some other, smaller texts.  I started with a bunch of files and wound up
with one big file called `potential_poems_full`.

Let's talk for a minute about how programmers approach problems like this one.
What I've just done is sort of an old-school humanities take on things:
Metaphorically speaking, I took a book off the shelf and hauled it down to the
copy machine to xerox a bunch of pages, and now I'm going to start in on them
with a highlighter and some Post-Its or something.

This kind of operation will often trigger a cascade of questions in the
programmer-mind:

- What if, halfway through the project, I realize my selection criteria were all
  wrong and have to backtrack?

- What if I discover corrections that also need to be made in the source documents?

- What if I want to access metadata, like the original location of a file?

- Why am I storing the same text in two different places?

A unifying theme of these questions is that they could all be answered by
invoking a little more abstraction.

-> * <-

Some kinds of abstraction are so common in the physical world that we often
forget they're part of a sophisticated technology.  For example, a good deal of
bicycle maintenance can be accomplished with a cheap multi-tool with a few
different sizes of hex wrench and a couple of screwdrivers.

A hex wrench or screwdriver doesn't really know anything about bicycles.  All
it _really_ knows about is fitting into a space and allowing torque to be
applied.  Standardized fasteners and adjustment mechanisms on a bicycle ensure
that the work can be done anywhere, by anyone with a certain set of tools.
Standard tools mean that if you can work on a particular bike, you can work on
_most_ bikes, and even on things that aren't bikes at all, but were designed by
people with the same abstractions in mind.

The relationship between a wrench, a bolt, and the purpose of a bolt is a lot
like something we call _indirection_ in software.  Programs like `grep` or
`cat` don't really know anything about poetry.  All they _really_ know about is
finding lines of text in input, or sticking inputs together.  Files, lines, and
text are like standardized fasteners that allow a user who can work on one kind
of data (be it poetry, a list of authors, the source code of a program) to use
the same tools for other problems and other data.

-> * <-

When I first started writing stuff on the web, I edited a page -- a single HTML
file -- by hand.  When the entries on my nascent blog got old, I manually
cut-and-pasted them to archive files with names like `old_main97.html`, which
held all of the stuff I'd written in 1997.

I should say that I'm not trying to hold this up as an example of youthful
folly.  In fact, it worked pretty well, and just having a single, static file
that you can open in any text editor has turned out to be a _lot_ more
future-proof than the sophisticated blogging software people were starting to
write at the time.

And yet.  Something about this habit nagged at my developing programmer mind
after a few years.  It was just a little bit too manual and repetitive, a
little bit silly to have to write things like a table of contents by hand, or
move entries around by copy-and-pasting them to different files.  Since I knew
the date for each entry, and wanted to make them navigable on that basis, why
not define a directory structure for the years and months, and then write a
file to hold each day?  That way, all I'd have to do is concatenate the files
in one directory to display any given month:

    $ cat ~/p1k3/archives/2014/1/* | head -10
    <h1>Sunday, January 12</h1>
    
    <h2>the one casey is waiting for</h2>
    
    <freeverse>
    after a while
    the thing about drinking
    is that it just feeds
    what you drink to kill
    and kills

I ultimately wound up writing a few thousand lines of Perl to do the actual
work, but the essential idea of the thing is still little more than invoking
`cat` on some stuff.

I didn't know the word for it at the time, but what I was reaching for was a
kind of indirection.  By putting blog posts in a specific directory layout, I
was creating a simple model of the temporal structure that I considered their
most important property.  Now, if I want to write commands that ask questions
about my blog posts or re-combine them in certain ways, I can address my
concerns to this model.  Maybe, for example, I want a rough idea how many words
I've written in blog posts so far in 2014:

    $ find ~/p1k3/archives/2014/ -type f | xargs cat | wc -w
    6677

Maybe I want to see a table of contents:

<!-- exec -->

    $ find ~/p1k3/archives/2014/ -type d | xargs ls -v | head -10
    /home/brennen/p1k3/archives/2014/:
    1
    2
    3
    
    /home/brennen/p1k3/archives/2014/1:
    5
    12
    14
    15

<!-- end -->

Or find the subtitles I used in 2013:

<!-- exec -->

    $ find ~/p1k3/archives/2012/ -type f | xargs perl -ne 'print "$1\n" if m/.*<h2>(.*?)<\/h2>.*/'
    pursuit
    fragment
    this poem again
    i'll do better next time
    timebinding animals
    more observations on gear nerdery &amp; utility fetishism
    thrift
    A miracle, in fact, means work
    <em>technical notes for late october</em>, or <em>it gets dork out earlier these days</em>
    radio
    light enough to travel
    12:06am
    "figures like Heinlein and Gingrich"

<!-- end -->

The crucial thing about this is that the filesystem _itself_ is just like `cat`
and `grep`:  It doesn't know anything about blogs (or poetry), and it's
basically indifferent to the actual _structure_ of a file like
`~/p1k3/archives/2014/1/12`.  What the filesystem knows is that there are files
with certain names in certain places.  It need not know anything about the
_meaning_ of those names in order to be useful; in fact, it's best if it stays
agnostic about the question, for this enables us to assign our own meaning to a
structure and manipulate that structure with the standard tools.

-> * <-
