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

What's worth noticing here is that `diff` doesn't really care whether it's
looking at shell scripts or a list of filenames or what-have-you.  Its
specialty is text files with lines made out of characters, which works well for
lots of programming languages, but could just as easily be applied to an
English text.

Since I have a couple of versions ready to hand, let's apply this to a text
with some well-known variations and a bit of a literary legacy.  Here's the
first day of the Genesis creation narrative in a couple of English
translations:

<!-- exec -->

    $ cat genesis_nkj
    In the beginning God created the heavens and the earth.  The earth was without
    form, and void; and darkness was on the face of the deep.  And the Spirit of
    God was hovering over the face of the waters.  Then God said, "Let there be
    light"; and there was light.  And God saw the light, that it was good; and God
    divided the light from the darkness.  God called the light Day, and the darkness
    He called Night.  So the evening and the morning were the first day.

<!-- end -->

<!-- exec -->

    $ cat genesis_nrsv
    In the beginning when God created the heavens and the earth, the earth was a
    formless void and darkness covered the face of the deep, while a wind from
    God swept over the face of the waters.  Then God said, "Let there be light";
    and there was light.  And God saw that the light was good; and God separated
    the light from the darkness.  God called the light Day, and the darkness he
    called Night.  And there was evening and there was morning, the first day.

<!-- end -->

What happens if we diff them?

<!-- exec -->

    $ diff -u genesis_nkj genesis_nrsv
    --- genesis_nkj	2014-05-11 16:28:29.692508461 -0600
    +++ genesis_nrsv	2014-05-11 16:28:29.744508459 -0600
    @@ -1,6 +1,6 @@
    -In the beginning God created the heavens and the earth.  The earth was without
    -form, and void; and darkness was on the face of the deep.  And the Spirit of
    -God was hovering over the face of the waters.  Then God said, "Let there be
    -light"; and there was light.  And God saw the light, that it was good; and God
    -divided the light from the darkness.  God called the light Day, and the darkness
    -He called Night.  So the evening and the morning were the first day.
    +In the beginning when God created the heavens and the earth, the earth was a
    +formless void and darkness covered the face of the deep, while a wind from
    +God swept over the face of the waters.  Then God said, "Let there be light";
    +and there was light.  And God saw that the light was good; and God separated
    +the light from the darkness.  God called the light Day, and the darkness he
    +called Night.  And there was evening and there was morning, the first day.

<!-- end -->

Kind of useless, right?  If a given line differs by so much as a character,
it's not the same line.  This highlights the limitations of `diff` for comparing
things that

- aren't logically grouped by line
- aren't easily thought of as versions of the same text with some lines changed

We could edit the files into a more logically defined structure, like
one-line-per-verse, and try again:

<!-- exec -->

    $ diff -u genesis_nkj_by_verse genesis_nrsv_by_verse
    --- genesis_nkj_by_verse	2014-05-11 16:51:14.312457198 -0600
    +++ genesis_nrsv_by_verse	2014-05-11 16:53:02.484453134 -0600
    @@ -1,5 +1,5 @@
    -In the beginning God created the heavens and the earth.
    -The earth was without form, and void; and darkness was on the face of the deep.  And the Spirit of God was hovering over the face of the waters.
    +In the beginning when God created the heavens and the earth,
    +the earth was a formless void and darkness covered the face of the deep, while a wind from God swept over the face of the waters.
     Then God said, "Let there be light"; and there was light.
    -And God saw the light, that it was good; and God divided the light from the darkness.
    -God called the light Day, and the darkness He called Night.  So the evening and the morning were the first day.
    +And God saw that the light was good; and God separated the light from the darkness.
    +God called the light Day, and the darkness he called Night.  And there was evening and there was morning, the first day.

<!-- end -->

That's a little better, but editing all that text felt suspiciously like work
just to get a quick comparison, and anyway the output still doesn't feel very
useful.

wdiff
-----

For cases like this, I'm fond of a tool called `wdiff`:

<!-- exec -->

    $ wdiff genesis_nkj genesis_nrsv
    In the beginning {+when+} God created the heavens and the [-earth.  The-] {+earth, the+} earth was [-without
    form, and void;-] {+a
    formless void+} and darkness [-was on-] {+covered+} the face of the [-deep.  And the Spirit of-] {+deep, while a wind from+}
    God [-was hovering-] {+swept+} over the face of the waters.  Then God said, "Let there be light";
    and there was light.  And God saw [-the light,-] that [-it-] {+the light+} was good; and God
    [-divided-] {+separated+}
    the light from the darkness.  God called the light Day, and the darkness
    [-He-] {+he+}
    called Night.  [-So the-]  {+And there was+} evening and [-the morning were-] {+there was morning,+} the first day.

<!-- end -->

Deleted words are surrounded by `[- -]` and inserted ones by `{+ +}`.  You can
even ask it to spit out HTML tags for insertion and deletion...

    $ wdiff -w '<del>' -x '</del>' -y '<ins>' -z '</ins>' genesis_nkj genesis_nrsv

...and come up with something your browser will render like this:

<blockquote>
<p>In the beginning <ins>when</ins> God created the heavens and the <del>earth.  The</del> <ins>earth, the</ins> earth was <del>without
form, and void;</del> <ins>a
formless void</ins> and darkness <del>was on</del> <ins>covered</ins> the face of the <del>deep.  And the Spirit of</del> <ins>deep, while a wind from</ins>
God <del>was hovering</del> <ins>swept</ins> over the face of the waters.  Then God said, "Let there be light";
and there was light.  And God saw <del>the light,</del> that <del>it</del> <ins>the light</ins> was good; and God
<del>divided</del> <ins>separated</ins>
the light from the darkness.  God called the light Day, and the darkness
<del>He</del> <ins>he</ins>
called Night.  <del>So the</del>  <ins>And there was</ins> evening and <del>the morning were</del> <ins>there was morning,</ins> the first day.</p>
</blockquote>

Burton H. Throckmorton, Jr. this ain't.  Still, it has its uses.
