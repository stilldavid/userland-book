5. general purpose programmering
================================

fear and loathing
-----------------

Let me begin this chapter with a confession:  I kind of hate shell scripts, and
I think it's ok if you hate them too.

That doesn't mean you shouldn't _know_ about them, or that you shouldn't
_write_ them.  I write little tiny ones all the time, and the ability to puzzle
through other people's scripts comes in handy.  Oftentimes, the best, most
tasteful way to automate something is to build a script out of the commonly
available commands.  The standard tools are already there on millions of
machines.  Many of them have been pretty well understood for a generation, and
most will probably be around for a generation or three to come.  They do neat
stuff.  Scripts let you build on things you've already figured out, and give
repeatable operations a memorable, user-friendly name.  They encourage reuse of
existing programs, and help express your ideas to people who'll come after you.

One of the reliable markers of powerful software is that it can be scripted: It
extends to its users some of the same power that its authors used in creating
it.  Scriptable software is to some extent _living_ software.  It's a book that
you, the reader, get to help write.

In all these ways, shell scripts are wonderful, and a little bit magical, and
actually, quietly indispensable to the machinery of modern civilization.

Unfortunately, in all the ways that a shell like Bash is weird, finicky, and
covered in 40 years of incidental cruft, long-form Bash scripts are even worse.
Bash is a useful glue language, particularly if you're already comfortable
wiring commands together.  Syntactic and conceptual innovations like pipes are
beautiful and necessary.  What Bash is _not_, despite its power, is a very good
general purpose programming language.  It turns out those are really nice to
have at your disposal.

Maybe you already know a general-purpose programming language.  A lot of the
people I imagine reading this are already comfortable in C, PHP, Python, Ruby,
or JavaScript.  
