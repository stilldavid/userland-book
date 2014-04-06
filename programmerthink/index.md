programmerthink
===============

In the [preceding chapter](../literary_problem), I worked through accumulating
a big piece of text from some other, smaller texts.  I started with a bunch of
files and wound up with one big file called `potential_poems_full`.

Let's talk for a minute about how programmers approach problems like this one.
What I've just done is sort of an old-school humanities take on things:
Metaphorically speaking, I took a book off the shelf and hauled it down to the
copy machine to xerox a bunch of pages, and now I'm going to start in on them
with a highlighter and some Post-Its or something.  A process like this will
often trigger a cascade of questions in the programmer-mind:

- What if, halfway through the project, I realize my selection criteria were all
  wrong and have to backtrack?
- What if I discover corrections that also need to be made in the source documents?
- What if I want to access metadata, like the original location of a file?
- What if I want to quickly re-order the poems according to some new criteria?
- Why am I storing the same text in two different places?

A unifying theme of these questions is that they could all be answered by
involving a little more abstraction.

-> * <-

Some kinds of abstraction are so common in the physical world that we can
forget they're part of a sophisticated technology.  For example, a good deal of
bicycle maintenance can be accomplished with a cheap multi-tool containing a
few different sizes of hex wrench and a couple of screwdrivers.

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

I'm not holding this up as an example of youthful folly.  In fact, it worked
fine, and just having a single, static file that you can open in any text
editor has turned out to be a _lot_ more future-proof than the sophisticated
blogging software people were starting to write at the time.

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

    $ find ~/p1k3/archives/2012/ -type f | xargs perl -ne 'print "$1\n" if m{<h2>(.*?)</h2>}'
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
structure and manipulate that structure with standard tools.

-> * <-

Back to the problem at hand:  I have this collection of files, and I know how
to extract the ones that contain poems.  My goal is to see all the poems and
collect the subset of them that I still find worthwhile.  Just knowing how to
grep and then edit a big file solves my problem, in a basic sort of way.  And
yet: Something about this nags at my mind.  I find that, just as I can already
use standard tools and the filesystem to ask questions about all of my blog
posts in a given year or month, I would like to be able to ask questions about
the set of interesting poems.

If I want the freedom to execute many different sorts of commands against this
set of poems, it begins to seem that I need a model.

When programmers talk about models, they often mean something that people in
the sciences would recognize:  We find ways to represent the arrangement of
facts so that we can think about them.  A structured representation of things
often means that we can _change_ those things, or at least derive new
understanding of them.

-> * <-

At this point in the narrative, I could pretend that my next step is
immediately obvious, but in fact it's not.  I spend a couple of days thinking
off and on about how to proceed, scribbling notes during bus rides and while
drinking beers at the pizza joint down the street.  I assess and discard ideas
which fall into a handful of broad approaches:

- Store blog entries in a relational database system which would allow me to
  associate them with data like "this entry is in a collection called 'ok
  poems'".
- Selectively build up a file containing the list of files with ok poems, and use
  it to do other tasks.
- Define a format for metadata that lives within entry files.
- Turn each interesting file into a directory of its own which contains a file
  with the original text and another file with metadata.

I discard the relational database idea immediately:  I like working with files,
and I don't feel like abandoning a model that's served me well for my entire
adult life.

Building up an index file to point at the other files I'm working with has a
certain appeal.  I'm already most of the way there with the `grep` output in
`potential_poems`. It would be easy to write shell commands to add, remove,
sort, and search entries.  Still, it doesn't feel like a very satisfying
solution unto itself.  I'd like to know that an entry is part of the collection
just by looking at the entry, without having to cross-reference it to a list
somewhere else.

What about putting some meaningful text in the file itself?  I thought about
a bunch of different ways to do this, some of them really complicated, and
eventually arrived at this:

    <!-- collection: ok-poems -->

The `<!-- -->` bits are how you define a comment in HTML, which means that
neither my blog code nor web browsers nor my text editor have to know anything
about the format, but I can easily find files with certain values.  Check it:

    $ find ~/p1k3/archives -type f | xargs perl -ne 'print "$ARGV[0]: $1 -> $2\n" if m{<!-- ([a-z]+): (.*?) -->};'
    /home/brennen/p1k3/archives/2014/2/9: collection -> ok-poems

That's an ugly one-liner, and I haven't explained half of what it does, but the
comment format actually seems pretty workable for this.  It's a little tacky to
look at, but it's simple and searchable.

Before we settle, though, let's turn to the notion of making each entry into a
directory that can contain some structured metadata in a separate file.
Imagine something like:

    $ ls ~/p1k3/archives/2013/2/9
    index  Meta

Here I use the name "index" for the main part of the entry because it's a
convention of web sites for the top-level page in a directory to be called
something like `index.html`.  As it happens, my blog software already supports
this kind of file layout for entries which contain multiple parts, image files,
and so forth.

    $ head ~/p1k3/archives/2013/2/9/index
    <h1>saturday, february 9</h1>
    
    <freeverse>
    midwinter midafternoon; depressed as hell
    sitting in a huge cabin in the rich-people mountains
    writing a sprawl, pages, of melancholic midlife bullshit
    
    outside the snow gives way to broken clouds and the
    clear unyielding light of the high country sun fills

    $ cat ~/p1k3/archives/2013/2/9/Meta
    collection: ok-poems

It would then be easy to `find` files called `Meta` and grep them for
`collection: ok-poems`.

What if I put metadata right in the filename itself, and dispense with the grep
altogether?

    $ ls ~/p1k3/archives/2013/2/9
    index  meta-ok-poem

    $ find ~/p1k3/archives -name 'meta-ok-poem'
    /home/brennen/archives/2013/2/9/meta-ok-poem

There's a lot to like about this.  For one thing, it's immediately visible in a
directory listing.  For another, it doesn't require searching through thousands
of lines of text to extract a specific string.  If a directory has a
`meta-ok-poem` in it, I can be pretty sure that it will contain an interesting
`index`.

What are the downsides?  Well, it requires transforming lots of text files into
directories-containing-files.  I might automate that process, but it's still a
little tedious and it makes the layout of the entry archive more complicated
overall.  There's a cost to doing things this way.  It lets me extend my
existing model of a blog entry to include arbitrary metadata, but it also adds
steps to writing or finding blog entries.

Abstractions usually cost you something.  Is this one worth the hassle?
