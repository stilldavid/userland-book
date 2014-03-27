programmerthink
===============

In the preceding chapter, I worked through accumulating a big piece of text
from some other, smaller texts.  I started with a bunch of files and wound up
with one big file called `potential_poems_full`.

Let's talk for a minute about how programmers approach problems like this one.
Because what I've just done is sort of an old-school humanities take on things:
Metaphorically speaking, I just took a book off the shelf and hauled it down to
the copy machine and flipped through to a bunch of pages and made a stack of
copies and now I'm going to start in on them with a highlighter and some
Post-Its or something.

This kind of operation will often trigger a cascade of questions in the
programmer-mind:

- What if, halfway through the project, I realize my selection criteria were all
  wrong and have to backtrack?

- What if I discover corrections that also need to be made in the source documents?

- What if I want to access metadata, like the original location of a file?

- Why am I storing the same text in two different places?

A unifying theme of these questions is that they could all be answered if we
invoked a little more abstraction.

Some kinds of abstraction are so common in the physical world that we often
forget they're part of a sophisticated technology.  For example, a good deal of
bicycle maintenance can be accomplished with a cheap multi-tool with a few
different sizes of hex wrench and a couple of screwdrivers.

A hex wrench or screwdriver doesn't really know anything about bicycles.  All
it _really_ knows about is fitting into a certain size and shape of indentation
and allowing torque to be applied.  Standardized fasteners, fittings, and
adjustment mechanisms on a bicycle ensure that the work can be done anywhere,
by anyone with a certain set of tools.  Standard tools mean that if you can
work on a particular bike, you can work on _most_ bikes, and even on things
that aren't bikes at all, but were designed by people with the same
abstractions in mind.

The relationship between a wrench, a bolt, and the purpose of a bolt is a lot
like something we call _indirection_ in software.  Software like `grep` or
`cat` doesn't really know anything about poetry.  All it _really_ knows about
is finding lines of text in its input, or sticking its input together.  Files,
lines, and text are like standardized fasteners that allow a user who can work
on one kind of data (be it poetry, or a list of authors, or the source code of
a program) to use the same tools for other problems and other data.


