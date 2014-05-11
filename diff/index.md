6. one of these things is not like the others
=============================================

If you're the sort of person who took a few detours into the history of
religion in college, you might be familiar with some of the ways people used to
do textual comparison.  When pen, paper, and typesetting were what scholars had
to work with, they did some surprisingly sophisticated things in order to
expose the relationships between multiple pieces of text.

{photo: some textual criticism tools}

Here's a book I got in college:  _Gospel Parallels: A Comparison of the
Synoptic Gospels_, by Burton H. Throckmorton, Jr.  It breaks up three books
from the Bible by the stories and themes that they contain, and shows the
overlapping sections of each book that contain parallel texts.  You can work
your way through and see what parts only show up in one book, or in two but not
the other, or in all three.  These kinds of tools support all sorts of
theoretical stuff about which books copied each other and how, and what other
sources they might have copied that we've since lost.

This is some _incredibly_ dry material, even if you kind of dig thinking about
questions like how and when an important religious book was written and
compiled.  It takes a special temperament to actually sit poring over
fragmentary texts in ancient languages and do these painstaking comparisons.
Even if you're a writer or editor and work with a lot of revisions of a text,
there's a good chance you rarely do this kind of comparison on your own work,
because that shit is _tedious_.

diff
----

It turns out that academics aren't the only people who need tools for comparing
different versions of a text.  Working programmers, in fact, need to do this
_constantly_.  Programmers are also happiest when putting off the _actual_ task
at hand to solve some incidental problem that cropped up along the way, so by
now there are a lot of ways to say "here's how this file is different from this
file", or "here's how this file is different from itself a year ago".

Let's look at a couple of shell scripts from an earlier chapter:

<!-- exec -->

    $ cat ../script/okpoems
    #!/bin/bash
    
    # find all the marker files and get the name of
    # the directory containing each
    find ~/p1k3/archives -name 'meta-ok-poem' | xargs -n1 dirname
    
    exit 0

<!-- end -->

<!-- exec -->

    $ cat ../script/findprop
    #!/bin/bash
    
    if [ ! $1 ]
    then
      echo "usage: findprop <property>"
      exit
    fi
    
    # find all the marker files and get the name of
    # the directory containing each
    find ~/p1k3/archives -name $1 | xargs -n1 dirname
    
    exit 0

<!-- end -->

It's pretty obvious these are similar files, but do we know what _exactly_
changed between them at a glance?  It wouldn't be hard to figure out, once.  If
you wanted to be really certain about it, you could print them out, set them
side by side, and go over them with a highlighter.

Now imagine doing that for a bunch of files, some of them hundreds or even
thousands of lines long.  I've actually done that before, but I didn't feel
smart while I was doing it.  This is a job for software.

<!-- exec -->

    $ diff ../script/okpoems ../script/findprop
    2a3,8
    > if [ ! $1 ]
    > then
    >   echo "usage: findprop <property>"
    >   exit
    > fi
    > 
    5c11
    < find ~/p1k3/archives -name 'meta-ok-poem' | xargs -n1 dirname
    ---
    > find ~/p1k3/archives -name $1 | xargs -n1 dirname

<!-- end -->

That's not the most human-friendly output, but it's a little simpler than it
seems at first glance.  It's basically just a way of describing the changes
needed to turn `okpoems` into `findprop`.  The string `2a3,8` can be read as
"at line 2, add lines 3 through 8".  Lines with a `>` in front of them are
added.  `5c11` can be read as "line 5 in the original file becomes line 11 in
the new file", and the `<` line is replaced with the `>` line.  If you wanted,
you could take a copy of the original file and apply these instructions by hand
in your text editor, and you'd wind up with the new file.

A lot of people (me included) prefer what's known as a "unified" diff, because
it's easier to read and offers context for the changed lines.  We can ask for
one of these with `diff -u`:

<!-- exec -->

    $ diff -u ../script/okpoems ../script/findprop
    --- ../script/okpoems	2014-04-19 00:08:03.321230818 -0600
    +++ ../script/findprop	2014-04-21 21:51:29.360846449 -0600
    @@ -1,7 +1,13 @@
     #!/bin/bash
     
    +if [ ! $1 ]
    +then
    +  echo "usage: findprop <property>"
    +  exit
    +fi
    +
     # find all the marker files and get the name of
     # the directory containing each
    -find ~/p1k3/archives -name 'meta-ok-poem' | xargs -n1 dirname
    +find ~/p1k3/archives -name $1 | xargs -n1 dirname
     
     exit 0

<!-- end -->

That's a little longer, and has some metadata we might not always care about,
but if you look for lines starting with `+` and `-`, it's easy to read as
"added these, took away these".  This diff tells us at a glance that we added
some lines to complain if we didn't get a command line argument, and replaced
`'meta-ok-poem'` in the `find` command with that argument.  Since it shows us
some context, we have a pretty good idea where those lines are in the file
and what they're for.

What if we don't care exactly _how_ the files differ, but only whether they
do?

<!-- exec -->

    $ diff -q ../script/okpoems ../script/findprop
    Files ../script/okpoems and ../script/findprop differ

<!-- end -->

I use `diff` a lot in the course of my day job, because I spend a lot of time
needing to know just how two programs differ.  Just as importantly, I often
need to know how (or whether!) the _output_ of programs differs.  As a concrete
example, I want to make sure that `findprop meta-ok-poem` is really a suitable
replacement for `okpoems`.  Since I expect their output to be identical, I can
do this:

<!-- exec -->

    $ ../script/okpoems > okpoem_output
    
<!-- end -->

<!-- exec -->

    $ ../script/findprop meta-ok-poem > findprop_output
    
<!-- end -->

<!-- exec -->

    $ diff -s okpoem_output findprop_output
    Files okpoem_output and findprop_output are identical

<!-- end -->

The `-s` just means that `diff` should explicitly tell us if files are the
**s**ame.  Otherwise, it'd output nothing at all, because there aren't any
differences.

What's worth noticing about this is that `diff` doesn't really care whether
it's looking at shell scripts or a list of filenames or what-have-you.  Its
specialty is text files with lines made out of characters, which works well for
lots of programming languages and suchlike things, but could just as easily be
applied to an English text.


