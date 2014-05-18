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

And in fact, as of mid-2014, it's still pretty common.  Any number of smart
people you know probably have desktops full of folder icons full of still
_other_ folder icons named things like `version_six_KEEP` which in turn are
full of files called things like `use_this_one.jpg`.  Still, the last decade or
so has seen a widespread realization in the technical world that this is a
problem for software.

The software in question is variously known as revision tracking, source code
management, revision version control, and probably half a dozen other things.
As some of the terms suggest, it's overwhelmingly designed with programmers in
mind, and it works best with the kinds of text files that programmers rely on.
Because it's built by and for people with an inordinately high tolerance for
jargon and complexity, it tends towards weird interfaces (even by the standards
of the command line) and confusing vocabulary.

If you're writing programs in any serious way, you should probably be using
version control.  

{this chapter a work in progress}
