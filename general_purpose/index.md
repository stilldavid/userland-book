5. general purpose programmering
================================

I didn't set out to write a book about programming, _as such_, but because
programming and the command line are so inextricably linked, this text
draws near the subject almost of its own accord.

If you're not terribly interested in programming, this chapter can easily
enough be skipped.  It's more in the way of philosophical rambling than
concrete instruction, and will be of most use to those with an existing
background in writing code.

-> ✢ <-

If you've used computers for more than a few years, you're probably viscerally
aware that most software is fragile and most systems decay.  In the time since
I took my first tentative steps into the little world of a computer (a friend's
dad's unidentifiable gaming machine, my own father's blue monochrome Zenith
laptop, the Apple II) the churn has been overwhelming.  By now I've learned my
way around vastly more software --- operating systems, programming languages and
development environments, games, editors, chat clients, mail systems --- than I
presently could use if I wanted to.  Most of it has gone the way of some
ancient civilization, surviving (if at all) only in faint, half-understood
cultural echoes and occasional museum-piece displays.  Every user of technology
becomes, in time, a refugee from an irretrievably recent past.

And yet, despite all this, the shell endures.  Most of the ideas in this book
are older than I am.  Most of them could have been applied in 1994 or
thereabouts, when I first logged on to multiuser systems running AT&T Unix.
Since the early 1990s, systems built on a fundamental substrate of Unix-like
behavior and abstractions have proliferated wildly, becoming foundational at
once to the modern web, the ecosystem of free and open software, and the
technological dominance ca. 2014 of companies like Apple, Google, and Facebook.

Why is this, exactly?

-> ✣ <-

As I've said (and hopefully shown), the commands you write in your shell
are essentially little programs.  Like other programs, they can be stored
for later use and recombined with other commands, creating new uses for
your ideas.

It would be hard to say that there's any _one_ reason command line environments
remain so vital after decades of evolution and hard-won refinement in computer
interfaces, but it seems like this combinatory nature is somewhere near the
heart of it.  The command line often lacks the polish of other interfaces we
depend on, but in exchange it offers a richness and freedom of expression
rarely seen elsewhere, and invites its users to build upon its basic
facilities.

What is it that makes last chapter's `addprop` preferable to the more specific
`markpoem`?  Let's look at an alternative implementation of `markpoem`:

<!-- exec -->

    $ cat simple_markpoem
    #!/bin/bash
    
    addprop $1 meta-ok-poem

<!-- end -->

Is this script trivial?  Absolutely.  It's so trivial that it barely seems to
exist, because I already wrote `addprop` to do all the heavy lifting and play
well with others, freeing us to imagine new uses for its central idea without
worrying about the implementation details.

Unlike `markpoem`, `addprop` doesn't know anything about poetry.  All it knows
about, in fact, is putting a file (or three) in a particular place.  And this
is in keeping with a basic insight of Unix:  Pieces of software that do one
very simple thing generalize well.  Good command line tools are like a hex
wrench, a hammer, a utility knife:  They embody knowledge of turning, of
striking, of cutting --- and with this kind of knowledge at hand, the user can
change the world even though no individual tool is made with complete knowledge
of the world as a whole.  There's a lot of power in the accumulation of small
competencies.

Of course, if your code is only good at one thing, to be of any use, it has to
talk to code that's good at other things.  There's another basic insight in the
Unix tradition:  Tools should be composable.  All those little programs have to
share some assumptions, have to speak some kind of trade language, in order to
combine usefully.  Which is how we've arrived at standard IO, pipelines,
filesystems, and text as as a lowest-common-denominator medium of exchange.  If
you think about most of these things, they have some very rough edges, but they
give otherwise simple tools ways to communicate without becoming
super-complicated along the way.

-> ✤ <-

What is the command line?

The command line is an environment of tool use.

So are kitchens, workshops, libraries, and programming languages.

-> ✥ <-

Here's a confession:  I don't like writing shell scripts very much, and I
can't blame anyone else for feeling the same way.

That doesn't mean you shouldn't _know_ about them, or that you shouldn't
_write_ them.  I write little ones all the time, and the ability to puzzle
through other people's scripts comes in handy.  Oftentimes, the best, most
tasteful way to automate something is to build a script out of the commonly
available commands.  The standard tools are already there on millions of
machines.  Many of them have been pretty well understood for a generation, and
most will probably be around for a generation or three to come.  They do neat
stuff.  Scripts let you build on ideas you've already worked out, and give
repeatable operations a memorable, user-friendly name.  They encourage reuse of
existing programs, and help express your ideas to people who'll come after you.

One of the reliable markers of powerful software is that it can be scripted: It
extends to its users some of the same power that its authors used in creating
it.  Scriptable software is to some extent _living_ software.  It's a book that
you, the reader, get to help write.

In all these ways, shell scripts are wonderful, a little bit magical, and
quietly indispensable to the machinery of modern civilization.

Unfortunately, in all the ways that a shell like Bash is weird, finicky, and
covered in 40 years of incidental cruft, long-form Bash scripts are even worse.
Bash is a useful glue language, particularly if you're already comfortable
wiring commands together.  Syntactic and conceptual innovations like pipes are
beautiful and necessary.  What Bash is _not_, despite its power, is a very good
general purpose programming language.  It's just not especially good at things
like math, or complex data structures, or not looking like a punctuation-heavy
variety of alphabet soup.

It turns out that there's a threshold of complexity beyond which life becomes
easier if you switch from shell scripting to a more robust language.  Just
where this threshold is located varies a lot between users and problems, but I
often think about switching languages before a script gets bigger than I can
view on my screen all at once.  `addprop` is a good example:

<!-- exec -->

    $ wc -l ../script/addprop
    41 ../script/addprop

<!-- end -->

41 lines is a touch over what fits on one screen in the editor I usually use.
If I were going to add much in the way of features, I'd think pretty hard about
porting it to another language first.

What's cool is that if you know a language like C, Python, Perl, Ruby, PHP, or
JavaScript, your code can participate in the shell environment as a first class
citizen simply by respecting the conventions of standard IO, files, and command
line arguments.  Often, in order to create a useful utility, it's only
necessary to deal with `STDIN`, or operate on a particular sort of file, and
most languages offer simple conventions for doing these things.

-> * <-

I think the shell can be taught and understood as a humane environment, despite
all of its ugliness and complication, because it offers the materials of its
own construction to its users, whatever their concerns.  The writer, the
philosopher, the scientist, the programmer:  Files and text and pipes know
little enough about these things, but in their very indifference to the
specifics of any one complex purpose, they're adaptable to the basic needs of
many.  Simple utilities which enact simple kinds of knowledge survive and
recombine because there is a wisdom to be found in small things.

Files and text know nothing about poetry, nothing in particular of the human
soul.  Neither do pen and ink, printing presses or codex books, but somehow we
got Shakespeare and Montaigne.
