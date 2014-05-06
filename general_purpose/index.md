5. general purpose programmering
================================

fear and loathing
-----------------

Let me begin this chapter with a confession:  I kind of hate shell scripts, and
I think it's ok if you hate them too.

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
general purpose programming language.  It's just not especially good for things
like math, or complex data structures, or not looking like a punctuation-heavy
variety of alphabet soup.

It turns out that there's a threshold of complexity beyond which life is easier
if you switch from shell scripting to a more robust language.  Just where this
threshold is located varies a lot between users and problems, but I often start
thinking about switching languages before a script gets bigger than I can view
on my screen all at once.  Last chapter's `addprop` is a good example:

<!-- exec -->

    $ wc -l ../script/addprop
    41 ../script/addprop

<!-- end -->

41 lines is a touch over what fits on one screen in the editor I usually use.
If I were going to add much in the way of features, I'd think pretty hard about
porting it to another language first.

warm fuzzies
------------

What's really beautiful about programming in the context of the shell is that,
as long as you follow certain conventions, it doesn't matter _too_ much what
language you favor.  If your code works with text files and/or standard input,
there's a good chance it can fit nicely into the rest of the ecosystem.

Here's the help text for a utility I wrote a little while ago:

<!-- exec -->

    $ words -h
    Usage: words [-ucaih] [-s n] [-b n] [-d pattern] [file]
    Split input into individual words, crudely understood.
    
        -u:  print each unique word only once
        -c:  print a count of words and exit
        -uc: print a count for each unique word
        -a:  strip non-alphanumeric characters for current locale
        -i:  coerce all to lowercase, ignore case when considering duplicates
        -h:  print this help and exit
    
        -s n, -b n: (s)hortest and (b)iggest words to pass through
        -d pattern: word delimiter (a Perl regexp)
    
    If no file is given, standard input will be read instead.
    
    Examples:
    
       # list all unique words, ignoring case, in foo:
       words -ui ./foo
    
       # find ten most used words longer than 6 letters in foo:
       words -uci -s6 foo | sort -nr | head -10
    

<!-- end -->

I wrote `words` because I wanted a simple command to split input up by word.
In the simplest terms, it does this:

<!-- exec -->

    $ echo "Fuck it, Dude.  Let's go bowling." | words -ia
    Fuck
    it,
    Dude.
    Let's
    go
    bowling.

<!-- end -->
