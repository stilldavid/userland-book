2. a literary problem
=====================

The [previous chapter](../literary_environment) introduced a bunch of tools
using contrived examples.  Now we'll look at a real problem, and work through a
solution by building on tools we've already covered.

So on to the problem:  I write poetry.

{rimshot dot wav}

Most of the poems I have written are not very good, but lately I've been
thinking that I'd like to comb through the last ten years' worth and pull
the least-embarrassing stuff into a single collection.

I've hinted at how the contents of my blog are stored as files, but let's take
a look at the whole thing:

    $ ls -F ~/p1k3/archives/
    1997/  2003/  2009/  bones/     meta/
    1998/  2004/  2010/  chapbook/  winfield/
    1999/  2005/  2011/  cli/       wip/
    2000/  2006/  2012/  colophon/
    2001/  2007/  2013/  europe/
    2002/  2008/  2014/  hack/

(`ls`, again, just lists files.  `-F` tells it to append a character that shows
it what type of file we're looking at, such as a trailing / for directories.
`~` is a shorthand that means "my home directory", which in this case is
`/home/brennen`.)

Each of the directories here holds other directories.  The ones for each year
have sub-directories for the months of the year, which in turn contain files
for the days.  The files are just little pieces of HTML and Markdown and some
other stuff.  Many years ago, before I really knew how to program, I wrote a
script to glue them all together into a web page and serve them up to visitors.
This sounds complicated, but all it really means is that if I want to write a
blog entry, I just open a file and type some stuff.  Here's an example for
March 1st:

<!-- exec -->

    $ cat ~/p1k3/archives/2014/3/1
    <h1>Saturday, March 1</h1>
    
    <markdown>
    Sometimes I'm going along on a Saturday morning, still a little dazed from the
    night before, and I think something like "I should just go write a detailed
    analysis of hooded sweatshirts".  Mostly these thoughts don't survive contact
    with an actual keyboard.  It's almost certainly for the best.
    </markdown>

<!-- end -->

And here's an older one that contains a short poem:

<!-- exec -->

    $ cat ~/p1k3/archives/2012/10/9
    <h1>tuesday, october 9</h1>
    
    <freeverse>i am a stateful machine
    i exist in a manifold of consequence
    a clattering miscellany of impure functions
    and side effects</freeverse>

<!-- end -->

Notice that `<freeverse>` bit?  It kind of looks like an HTML tag, but it's
not.  What it actually does is tell my blog script that it should format the
text it contains like a poem.  The specifics don't matter for our purposes
(yet), but this convention is going to come in handy, because the first thing I
want to do is get a list of all the entries that contain poems.

Remember `grep`?

    $ grep -ri '<freeverse>' ~/p1k3/archives > ~/possible_poems

Let's step through this bit by bit:

First, I'm asking `grep` to search **r**ecursively, **i**gnoring case.
"Recursively" just means that every time the program finds a directory, it
should descend into that directory and search in any files there as well.

    grep -ri

Next comes a pattern to search for.  It's in single quotes because the
characters `<` and `>` have a special meaning to the shell, and here we need
the shell to understand that it should treat them as literal angle brackets
instead.

    '<freeverse>'

This is the path I want to search:

    ~/p1k3/archives

Finally, because there are so many entries to search, I know the process will
be slow and produce a large list, so I tell the shell to redirect it to a file
called `possible_poems` in my home directory:

    > ~/possible_poems

This is quite a few instances...

    $ wc -l ~/possible_poems
    679 /home/brennen/possible_poems

...and it's also not super-pretty to look at:

    $ head -5 ~/possible_poems
    /home/brennen/p1k3/archives/2011/10/14:<freeverse>i've got this friend has a real knack
    /home/brennen/p1k3/archives/2011/4/25:<freeverse>i can't claim to strive for it
    /home/brennen/p1k3/archives/2011/8/10:<freeverse>one diminishes or becomes greater
    /home/brennen/p1k3/archives/2011/8/12:<freeverse>
    /home/brennen/p1k3/archives/2011/1/1:<freeverse>six years on

Still, it's a decent start.  I can see paths to the files I have to check, and
usually a first line.  Since I use a fancy text editor, I can just go down the
list opening each file in a new window and copying the stuff I'm interested in
to a new file.

This is good enough for government work, but what if instead of jumping around
between hundreds of files, I'd rather read everything in one file and just weed
out the bad ones as I go?

    $ cat `grep -ril '<freeverse>' ~/p1k3/archives` > ~/possible_poems_full

This probably bears some explaining.  `grep` is still doing all the real work
here.  The main difference from before is that `-l` tells grep to just list any
files it finds which contain a match.

    `grep -ril '<freeverse>' ~/p1k3/archives`

Notice those backticks around the grep command?  This part is a little
trippier.  It turns out that if you put backticks around something in a
command, it'll get executed and replaced with its result, which in turn gets
executed as part of the larger command.  So what we're really saying is
something like:

    $ cat [all of the files in the blog directory with <freeverse> in them]

Did you catch that?  I just wrote a command that rewrote itself as a
_different_, more specific command.  And it appears to have worked on the
first try:

    $ wc ~/possible_poems_full
     17628  80980 528699 /home/brennen/possible_poems_full

Welcome to wizard school.
