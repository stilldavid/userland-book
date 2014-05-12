7. version control
==================

Tools like `diff` and `wdiff` are useful when you have two versions of a file
and need to reason about their differences.  Very often, however, the questions
it's useful to ask about a file are along the lines of "how have I changed this
file today?" or "in what ways does this file differ from a year ago?"

It's certainly possible to manually keep snapshots of a file from different
points in time.  It's even _theoretically_ possible to be rigorous and
organized about this, but no one I've ever known has quite managed it.  It used
to be common to see directories like this:

<!-- exec -->

    $ ls some_project/
    current
    current.bak
    v1
    v2
    v3
    v3_january

<!-- end -->

And in fact, as of mid-2014, it's still pretty common.  Any number of the
smarter people you know probably have desktops full of folder icons full of
still _other_ folder icons named things like `version_six_KEEP` which in turn
are full of files called things like `use_this_one.jpg`.  Still, the last
decade or so has seen a widespread realization in the technical community that
this is a problem better solved by software.

The software in question is variously known as revision tracking, source code
management, version control, and probably half a dozen other things.  As some
of the terms might lead you to expect, it's overwhelmingly designed with
programmers in mind, and it mostly works with the kinds of text files that
programmers rely on.  Because it's built by and for people with an inordinately
high tolerance for jargon and complexity, it tends towards weird interfaces
(even by the standards of the command line) and confusing vocabulary.

If you're writing programs in any serious way, you should be using version
control for anything bigger than a few lines of code.  Being able to reason
about change across time is essential to your work, and explicit visibility of
the changes you're making at any given time is astonishingly useful.

{work in progress}
