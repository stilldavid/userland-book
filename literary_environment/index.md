the command line as a literary environment
==========================================

Writing, particularly writing of any real scope or complexity, is very much a
technical task.  It makes demands, both physical and psychological, of its
practitioners.  As with programmers, woodworkers, graphic artists, and farmers,
writers exhibit strong preferences in their tools, materials, and environment,
and they do so because they're engaged in a physically and cognitively
challenging task.

My thesis is that the modern Linux command line is a pretty good environment
for working with English prose and prosody, and by extension offers features
you might find useful in your own work.

I've chosen writing as a point of departure because, aside from web
development, it's what I use a computer for most.  I want to shine a light on
the humane potential of ideas that are usually understood as esoteric nerd
trivia.  Computers have utterly transformed the practice of writing within the
space of my lifetime, but it seems to me that writers as a class miss out on
many of the software tools and patterns taken as a given in more "technical"
fields.  Which is to say that even if you're not a writer by habit or trade,
there might still be something here for you.

The first assumption of what follows is that the bulk of your writing will be
stored and manipulated in plain text files, maybe with some simple markup for
formatting (basic HTML, Markdown, etc.).

Implicit in this notion is that, if you rely on Word or Open Office or Google
Docs, I'm suggesting you abandon those tools for a lot of tasks.  That may seem
like quite a stretch.  Humor me for a while.

-> * <-

Let's do the terms-and-definitions thing.  What software are we actually
talking about when we say "the command line"?

For the purposes of this discussion, we're talking about an environment built
on a very old paradigm called Unix.

{jurassic park dot gif}

...except what classical Unix really looks like is this:

{super old school blinking cursor dot gif}

The Unix-like environment we're going to use isn't very classical, really.
It's an operating system kernel called Linux, combined with a bunch of things
written by other people (people in the GNU and Debian projects, and many
others).  Purists will tell you that this isn't properly Unix at all.  In
strict historical terms they're right, or at least a certain kind of right, but
for the purposes of my cultural agenda I'm going to ignore them right now.

{cut to actual terminal blinkety blinking on the projector}

This is what's called a shell.  The shell is actually distinct from a lot of
parts of the operating system it runs on, and you can use many different
shells, but they all pretty much operate on the same basic idea:  You move
around the filesystem on the computer and run programs by typing commands.
Commands can be combined in various ways to make programs of their own, and in
fact the way you use the computer is often just to write little programs that
invoke other programs, turtles-all-the-way-down style.

The standard shell these days is something called Bash, so we'll use Bash.
It's what you'll most often see in the wild.  Like most shells, Bash is ugly
and stupid in more ways than it is possible to easily summarize.  It's also an
incredibly powerful and expressive piece of software.

{some sort of ADVENTURE derail here}

You can think of the shell as a kind of environment you inhabit, the same way
your character might inhabit an adventure game or a MUD.  Or as a sort of
vehicle for getting around inside of computers.  The difference is that instead
of navigating around virtual rooms and hallways with commands like `GO WEST`,
you navigate between directories by typing commands like `cd documents`.

(SIDE NOTE: In the Windows and Macintosh world, directories have been called
"folders" for a long time now.  This isn't the _worst_ metaphor for what's
really going on, and it's so pervasive by now that it's not worth fighting
about.  It's also not exactly a _great_ metaphor, since computer filesystems
aren't structured very much like the filing cabinets of yore.  A directory acts
a lot like a container, but for most purposes in the modern context it's an
infinitely expandable one which may contain nested sub-spaces much larger than
itself.

The vendors of mass-market operating systems are, as we speak, striving to
paper over the existence of the filesystem, one of the most powerful and
liberating abstractions in the history of human thought.  There might be an
argument that little folder icons were the first step along this path.

That said, it probably doesn't matter much.  Real-world exposure to old-school
paper filing systems is plummeting among people with access to computers, and
anyway I suspect that people are actually pretty good at metaphor.)

(SIDE NOTE: You could also think of the shell as like a notebook you carry
around work, full of todo lists and design ideas and sketches of dinosaurs
fighting with laser tanks.  There are a lot of potential metaphors here.)

When you're in the shell, you have many tools at your disposal - programs that
can be used on many different files, or chained together with other programs.
They tend to have weird, cryptic names, but a lot of them do very simple
things.  Tasks that might be a menu item in Word, like counting the number of
words in a document, or finding a particular phrase, are often programs unto
themselves.

learn you an editor
-------------------

An editor is in the business of opening up text files and changing their
contents.  This is where I spend most of my time that isn't in a web browser,
because it's where I write both code and prose.  It turns out that the features
which make a good code editor overlap a lot with the ones that make a good
editor of English sentences.

So what should you use?  Well, there have been other contenders in recent
years, but in truth nothing comes close to dethroning the Great Old Ones of
text editing.  Emacs is a creature both primal and sophisticated, like an
avatar of some interstellar civilization that evolved long before multicellular
life existed on earth and seeded the galaxy with incomprehensible artefacts and
colossal engineering projects.  Vim is like a lovable chainsaw-studded robot
with the most elegant keyboard interface in history secretly emblazoned on its
shining diamond heart.

It's worth the time it takes to learn one of the serious editors (there are few
things in the world of technology as likely to expand your abilities), but
there are easier places to start.  Nano is inoffensive and easy to pick up.
Most any desktop environment provides a GUI editor that will work well enough
to experiment with.  It's not necessary to jump off the cliff of learning an
editor older than you are, at least not right away.

cat
---

Suppose you have some files, and you're curious what's in them.  Maybe opening
them up in an editor seems like it'd be a lot of work.  For example, suppose
you've got a list of authors you're planning to reference in some piece of
work, and you just want to check its contents real quick-like.  This is where
our friend `cat` comes in:

<!-- exec -->

    $ cat authors_sff
    Ursula K. Le Guin
    Jo Walton
    Pat Cadigan
    John Ronald Reuel Tolkien
    Vanessa Veselka
    James Tiptree, Jr.
    John Brunner

<!-- end -->

Ok, so why, you might be asking at this point, is the command to dump out the
contents of a file to a screen called `cat`?  What do felines have to do with
anything?

It turns out that `cat` is actually short for "concatenate", which is a long
word basically meaning "stick things together".  In programming, we usually
refer to sticking two bits of text together as "string concatenation", probably
because programmers like to feel like they're being very precise about very
simple actions.

Suppose you wanted to see the contents of a _set_ of author lists:

<!-- exec -->

    $ cat authors_sff authors_contemporary_fic authors_nat_hist
    Ursula K. Le Guin
    Jo Walton
    Pat Cadigan
    John Ronald Reuel Tolkien
    Vanessa Veselka
    James Tiptree, Jr.
    John Brunner
    Eden Robinson
    Vanessa Veselka
    Miriam Toews
    Gwendolyn L. Waring

<!-- end -->

a digression: wildcards
-----------------------

We're working with three filenames: `authors_sff`, `authors_contemporary_fic`,
and `authors_nat_hist`.  That's an awful lot of typing every time we want to do
something to all three files.  Fortunately, our shell offers a shorthand for
"all the files that start with `authors_`":

<!-- exec -->

    $ cat authors_*
    Eden Robinson
    Vanessa Veselka
    Miriam Toews
    Gwendolyn L. Waring
    Ursula K. Le Guin
    Jo Walton
    Pat Cadigan
    John Ronald Reuel Tolkien
    Vanessa Veselka
    James Tiptree, Jr.
    John Brunner

<!-- end -->

In Bash-land, `*` basically means "anything", and is known in the vernacular,
somewhat poetically, as a "wildcard".  You should always be careful with
wildcards, especially if you're doing anything destructive.  They can and will
surprise the unwary.  Still, once you're used to the idea, they will save you a
lot of RSI.

sort
----

To get back on track, there's a problem here.  Our author list is out of order,
and thus confusing to reference.  Fortunately, since one of the most basic
things you can do to a list is to sort it, someone else has already solved this
problem for us.  Here's a command that will give us some organization:

<!-- exec -->

    $ sort authors_*
    Eden Robinson
    Gwendolyn L. Waring
    James Tiptree, Jr.
    John Brunner
    John Ronald Reuel Tolkien
    Jo Walton
    Miriam Toews
    Pat Cadigan
    Ursula K. Le Guin
    Vanessa Veselka
    Vanessa Veselka

<!-- end -->

Does it bother you that they aren't sorted by last name?  Me too.  As a partial
solution, we can ask `sort` to use the second "field" in each line as its sort
key (by default, sort treats whitespace as a division between fields):

<!-- exec -->

    $ sort -k2 authors_*
    John Brunner
    Pat Cadigan
    Ursula K. Le Guin
    Gwendolyn L. Waring
    Eden Robinson
    John Ronald Reuel Tolkien
    James Tiptree, Jr.
    Miriam Toews
    Vanessa Veselka
    Vanessa Veselka
    Jo Walton

<!-- end -->

That's closer, right?  It sorted on "Cadigan" and "Veselka" instead of "Pat"
and "Vanessa".  But of course it's still not really good enough, because the
second field in each line isn't necessarily the person's last name.

Let's set that one aside for a minute and deal with a different problem.

uniq
----

Notice how Vanessa Veselka shows up twice in our list of authors?  That's
useful if we want to remember that she's in more than one category, but
it's redundant if we're just worried about membership in the overall set
of authors.  Let's make sure our list doesn't contain repeating lines:

<!-- exec -->

    $ sort -k2 authors_* | uniq
    John Brunner
    Pat Cadigan
    Ursula K. Le Guin
    Gwendolyn L. Waring
    Eden Robinson
    John Ronald Reuel Tolkien
    James Tiptree, Jr.
    Miriam Toews
    Vanessa Veselka
    Jo Walton

<!-- end -->

There are a couple of important things to remember about `uniq`.

The first is that, in order to be useful, it requires its input to be
pre-sorted:  It moves through the lines in its input, and if it sees a line
more than once in sequence, it will only print that line once.  If you have a
bunch of files and you just want to see the unique lines across all of those
files, you probably need to run them through `sort` first.

The second is that `uniq` is very literal-minded.  Unless you tell it
otherwise, it cares what case the letters on a line are, and it pays attention
to things like whitespace.

a digression: options and redirection
-------------------------------------

Above, when we wanted to ask `sort` to behave differently, we gave it what is
known as an option.  Most programs with command-line interfaces will allow
their behavior to be changed by adding various options.  Options usually 
(but not always!) look like `-o` or `--option`.

For example, if we wanted to see unique lines, irrespective of case, with a
count of how often each line occurs, for a file called colors:

<!-- exec -->

    $ cat colors
    RED
    blue
    red
    BLUE
    Green
    green
    GREEN

<!-- end -->

...then we could do the following, where `-i` stands for "case **i**nsensitive and
`-c` stands for "**c**ount":

<!-- exec -->

    $ sort colors | uniq -i -c
          2 blue
          3 green
          2 red

<!-- end -->

There's one other important thing going on in this line:  The `|`, usually
called a "pipe", and probably found on your backslash key, is telling your
shell that instead of printing the output of `sort colors` right to your
terminal screen, it should send it to `uniq -i -c`.

{mario.gif}

Pipes are some of the most important magic in the shell.  When the people who
built Unix in the first place give interviews about the stuff they remember
from the early days, a lot of them reminisce about the invention of pipes and
all of the new stuff it immediately made possible.

Pipes let you control a thing called "standard IO".  In the world of the
command line, programs take **i**nput and produce **o**utput.  A pipe is a way
to hook the output from one program to the input of another.  Unlike a lot of
the weirdly named things you'll encounter in software, the metaphor here is
obvious and makes pretty good sense.  It even kind of looks like a physical
pipe.

So what happens if, instead of wanting to send the output of one program to
the input of another, you'd like to just stash it in a file for later use?

Check it out:

<!-- exec -->

    $ sort authors_* | uniq > all_authors
    
<!-- end -->

<!-- exec -->

    $ cat all_authors
    Eden Robinson
    Gwendolyn L. Waring
    James Tiptree, Jr.
    John Brunner
    John Ronald Reuel Tolkien
    Jo Walton
    Miriam Toews
    Pat Cadigan
    Ursula K. Le Guin
    Vanessa Veselka

<!-- end -->

We'll use these features from here on out.

further digression: man pages and --help
----------------------------------------

I mentioned that the behavior of most commands can be changed by giving them
different options.  All well and good if you happen to know what options a
certain utility takes, but what if you don't?

What you want is called a man (short for manual) page.  (It's sort of an
unfortunate abbreviation.)

    $ man sort

    SORT(1)                         User Commands                        SORT(1)



    NAME
           sort - sort lines of text files

    SYNOPSIS
           sort [OPTION]... [FILE]...
           sort [OPTION]... --files0-from=F

    DESCRIPTION
           Write sorted concatenation of all FILE(s) to standard output.

...and so on.  You can also ask a lot of commands directly for help on how to
use them:

    $ uniq --help
    Usage: uniq [OPTION]... [INPUT [OUTPUT]]
    Filter adjacent matching lines from INPUT (or standard input),
    writing to OUTPUT (or standard output).

    With no options, matching lines are merged to the first occurrence.

...and so on.

If you're not sure what _program_ you want to use to solve a given problem, you
might try searching all the man pages on the system for a keyword.  `man`
itself has an option to let you do this - `man -k keyword` - but most systems
have an alias for this called `apropos`, which I like to use because it's easy
to remember if you imagine yourself saying "apropos of [some problem I
have]..."

<!-- exec -->

    $ apropos sort
    alphasort (3)        - scan a directory for matching entries
    apt-sortpkgs (1)     - Utility to sort package index files
    bsearch (3)          - binary search of a sorted array
    bunzip2 (1)          - a block-sorting file compressor, v1.0.6
    bzip2 (1)            - a block-sorting file compressor, v1.0.6
    comm (1)             - compare two sorted files line by line
    FcFontSetSort (3)    - Add to a font set
    FcFontSetSortDestroy (3) - DEPRECATED destroy a font set
    FcFontSort (3)       - Return list of matching fonts
    heapsort (3)         - sort functions
    mergesort (3)        - sort functions
    qsort (3)            - sort an array
    qsort_r (3)          - sort an array
    radixsort (3)        - radix sort
    sort (1)             - sort lines of text files
    sradixsort (3)       - radix sort
    tsort (1)            - perform topological sort
    versionsort (3)      - scan a directory for matching entries
    XConsortium (7)      - X Consortium information

<!-- end -->

It can be useful to know that the manual represented by `man` has numbered
sections for different kinds of manual pages.  Most of what the average user
needs to know about lives in section 1, so you'll often see the names of
different commands and programs written like `sort(1)` or `cat(1)`.  Like other
literary traditions, Unix is littered with this sort of convention.

wc
--

`wc` stands for **w**ord **c**ount.  It does about what you'd expect - it
counts the number of words in its input.

    $ wc index.md
      736  4117 24944 index.md

736 is the number of lines, 4117 the number of words, and 24944 the number of
characters in the file I'm writing right now.  I use this constantly.  Most
obviously, it's a good way to get an idea of how much you've written.  `wc` is
the tool I used to track my progress the last time I tried NaNoWriMo:

    $ find ~/p1k3/archives/2010/11 -regextype egrep -regex '.*([0-9]+|index)' -type f | xargs wc -w | grep total
     6585 total

<!-- exec -->

    $ cowsay 'embarrassing.'
     _______________
    < embarrassing. >
     ---------------
            \   ^__^
             \  (oo)\_______
                (__)\       )\/\
                    ||----w |
                    ||     ||

<!-- end -->

Anyway.  The less obvious thing about `wc` is that you can use it to count the
output of other commands.  Want to know _how many_ unique authors we have?

<!-- exec -->

    $ sort authors_* | uniq | wc -l
    10

<!-- end -->

This kind of thing is obviously trivial, but it comes in handy more often than
you might think.

reference tools: dict, aspell, cal, calendar, units
---------------------------------------------------

I'll preface this by saying that, of course, almost anyone who is writing
anything on a computer is going to use Google and Wikipedia, and the answer to
questions like "what does this word mean" or "what day did Easter fall on in
1992" is readily available to all of us.

{lmgtfy.gif}

That said, not everything has to live on the web all the time.  Sometimes you
know that if you jump over to your browser you're going to wind up lost in a
forest of cat GIFs and drama-laden social network updates.  Sometimes you're
writing a presentation on a Raspberry Pi, where trying to use a web browser is
like travelling back in time to the part of the 1990s when people were running
Netscape Navigator on 486s and we were all getting real excited about burnable
CDs.

So.  Want to know the definition of a word, or find useful synonyms?

    $ dict concatenate | head -10
    4 definitions found
    
    From The Collaborative International Dictionary of English v.0.48 [gcide]:
    
      Concatenate \Con*cat"e*nate\ (k[o^]n*k[a^]t"[-e]*n[=a]t), v. t.
         [imp. & p. p. {Concatenated}; p. pr. & vb. n.
         {Concatenating}.] [L. concatenatus, p. p. of concatenare to
         concatenate. See {Catenate}.]
         To link together; to unite in a series or chain, as things
         depending on one another.

Need to interactively spell-check your presentation notes?

    $ aspell check presentation

Want to know what the calendar looks like for this month?

<!-- exec -->

    $ cal
         April 2014       
    Su Mo Tu We Th Fr Sa  
           1 _ _2  3  4  5  
     6  7  8  9 10 11 12  
    13 14 15 16 17 18 19  
    20 21 22 23 24 25 26  
    27 28 29 30           
                          

<!-- end -->

How about for September, 1950?

<!-- exec -->

    $ cal -m9 1950
       September 1950     
    Su Mo Tu We Th Fr Sa  
                    1  2  
     3  4  5  6  7  8  9  
    10 11 12 13 14 15 16  
    17 18 19 20 21 22 23  
    24 25 26 27 28 29 30  
                          

<!-- end -->

a digression: head, tail, and cut
---------------------------------

Remember our old pal `cat`, which just splats everything it's given back to
standard output?

Sometimes you've got a piece of output that's more than you actually want to
deal with at once.  Maybe you just want to glance at the first few lines in a
file:

<!-- exec -->

    $ head -3 colors
    RED
    blue
    red

<!-- end -->

...or maybe you want to see the last thing in a list:

<!-- exec -->

    $ sort colors | uniq -i | tail -1
    red

<!-- end -->

...or maybe you're only interested in the first "field" in some list. You might
use `cut`  here, asking it to treat spaces as delimiters between fields and
return only the first field for each line of its input:

<!-- exec -->

    $ cut -d' ' -f1 ./authors_*
    Eden
    Vanessa
    Miriam
    Gwendolyn
    Ursula
    Jo
    Pat
    John
    Vanessa
    James
    John

<!-- end -->

Suppose we're curious what the few most commonly occurring first names on our
author list are?  Here's an approach, silly but effective, that combines a lot
of what we've discussed so far and looks like plenty of one-liners I wind up
writing in real life:

<!-- exec -->

    $ cut -d' ' -f1 ./authors_* | sort | uniq -ci | sort -n | tail -3
          1 Ursula
          2 John
          2 Vanessa

<!-- end -->

Let's walk through this one step by step:

First, we have `cut` extract the first field of each line in our author lists.

    cut -d' ' -f1 ./authors_*

Then we sort these results

    | sort

and pass them to `uniq`, asking it for a case-insensitive count of each
repeated line

    | uniq -ci

then sort again, numerically, 

    | sort -n

and finally, we chop off everything but the last three lines:

    | tail -3

If you wanted to make sure to count an individual author's first name
only once, even if that author appears more than once in the files,
you could instead do:

<!-- exec -->

    $ sort -u ./authors_* | cut -d' ' -f1 | uniq -ci | sort -n | tail -3
          1 Ursula
          1 Vanessa
          2 John

<!-- end -->

finding text: grep
------------------

After all those contortions, what if you actually just want to see _which lists_
an individual author appears on?

<!-- exec -->

    $ grep 'Vanessa' ./authors_*
    ./authors_contemporary_fic:Vanessa Veselka
    ./authors_sff:Vanessa Veselka

<!-- end -->

`grep` takes a string to search for and, optionally, a list of files to search
in.   If you don't specify files, it'll look through standard input instead:

<!-- exec -->

    $ cat ./authors_* | grep 'Vanessa'
    Vanessa Veselka
    Vanessa Veselka

<!-- end -->

Most of the time, piping the output of `cat` to `grep` is considered silly,
because `grep` knows how to find things in files on its own.  Many thousands of
words have been written on this topic by leading lights of the nerd community.

You've probably noticed that this result doesn't contain filenames (and thus
isn't very useful to us).  That's because all `grep` saw was the lines in the
files, not the names of the files themselves.

now you have n problems: regex & rabbit holes
---------------------------------------------

To close out this introductory chapter, let's spend a little time on a topic
that will likely vex, confound, and (occasionally) delight you for as long as
you are acquainted with the command line.

When I was talking about `grep` a moment ago, I fudged the details more than a
little by saying that it expects a string to search for.  What `grep`
_actually_ expects is a _pattern_.  Moreover, it expects a specific kind of
pattern, what's known as a _regular expression_, a cumbersome phrase frequently
shortened to regex.

There's a lot of theory about what makes up a regular expression.  Fortunately,
very little of it matters to the short version that will let you get useful
stuff done.  The short version is that a regex is like using wildcards in the
shell to match groups of files, but with more magic.

<!-- exec -->

    $ grep 'Jo.*' ./authors_*
    ./authors_sff:Jo Walton
    ./authors_sff:John Ronald Reuel Tolkien
    ./authors_sff:John Brunner

<!-- end -->

The pattern `Jo.*` says that we're looking for lines which contain a literal
`Jo`, followed by any quantity (including none) of any character.  In a regex,
`.` means "anything" and `*` means "any amount of the preceding thing".

`.` and `*` are magical.  In the particular dialect of regexen understood
by `grep`, other magical things include:

<table>
  <tr><td><code>^</code>    </td>  <td>start of a line                        </td></tr>
  <tr><td><code>$</code>    </td>  <td>end of a line                          </td></tr>
  <tr><td><code>[abc]</code></td>  <td>one of a, b, or c                      </td></tr>
  <tr><td><code>[a-z]</code></td>  <td>a character in the range a through z   </td></tr>
  <tr><td><code>[0-9]</code></td>  <td>a character in the range 0 through 9   </td></tr>

  <tr><td><code>+</code>    </td>  <td>one or more of the preceding thing     </td></tr>
  <tr><td><code>?</code>    </td>  <td>0 or 1 of the preceding thing          </td></tr>
  <tr><td><code>*</code>    </td>  <td>any number of the preceding thing      </td></tr>

  <tr><td><code>(foo|bar)</code></td>  <td>"foo" or "bar"</td></tr>
  <tr><td><code>(foo)?</code></td>  <td>optional "foo"</td></tr>
</table>

It's actually a little more complicated than that:  By default, if you want to
use a lot of the magical characters, you have to prefix them with `\`.  This is
both ugly and confusing, so unless you're writing a very simple pattern, it's
often easiest to call `grep -E`, for **E**xtended regular expressions, which
means that lots of characters will have special meanings.

Authors with 4-letter first names:

<!-- exec -->

    $ grep -iE '^[a-z]{4} ' ./authors_*
    ./authors_contemporary_fic:Eden Robinson
    ./authors_sff:John Ronald Reuel Tolkien
    ./authors_sff:John Brunner

<!-- end -->

A count of authors named John:

<!-- exec -->

    $ grep -c '^John ' ./all_authors
    2

<!-- end -->

Lines in this file matching the words "magic" or "magical":

    $ grep -iE 'magic(al)?' ./index.md
    Pipes are some of the most important magic in the shell.  When the people who
    shell to match groups of files, but with more magic.
    `.` and `*` are magical.  In the particular dialect of regexen understood
    by `grep`, other magical things include:
    use a lot of the magical characters, you have to prefix them with `\`.  This is
    Lines in this file matching the words "magic" or "magical":
        $ grep -iE 'magic(al)?' ./index.md

Find some "-agic" words in a big list of words:

<!-- exec -->

    $ grep -iE '(m|tr|pel)agic' /usr/share/dict/words
    magic
    magic's
    magical
    magically
    magician
    magician's
    magicians
    pelagic
    tragic
    tragically
    tragicomedies
    tragicomedy
    tragicomedy's

<!-- end -->

`grep` isn't the only - or even the most important - tool that makes use of
regular expressions, but it's a good place to start because it's one of the
fundamental building blocks for so many other operations.  Filtering lists of
things, matching patterns within collections, and writing concise descriptions
of how text should be transformed are at the heart of a practical approach to
Unix-like systems.  Regexen turn out to be a seductively powerful way to do
these things - so much so that they've crept their way into text editors,
databases, and full-featured programming languages.

There's a dark side to all of this, for the truth about regular expressions is
that they are ugly, inconsistent, brittle, and _incredibly_ difficult to think
clearly about.  They take years to master and reward the wielder with great
power, but they are also a trap: a temptation towards the path of cleverness
masquerading as wisdom.

-> * <-

I'll be returning to this theme, but for the time being let's move on.  Now
that we've established, however haphazardly, some of the basics, let's consider
their application to a real-world task.
