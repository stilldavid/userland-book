1. the command line as literary environment
===========================================

There're a lot of ways to structure an introduction to the command line.  I'm
going to start with writing as a point of departure because, aside from web
development, it's what I use a computer for most.  I want to shine a light on
the humane potential of ideas that are usually understood as nerd trivia.
Computers have utterly transformed the practice of writing within the space of
my lifetime, but it seems to me that writers as a class miss out on many of the
software tools and patterns taken as a given in more "technical" fields.

Writing, particularly writing of any real scope or complexity, is very much a
technical task.  It makes demands, both physical and psychological, of its
practitioners.  As with woodworkers, graphic artists, and farmers, writers
exhibit strong preferences in their tools, materials, and environment, and they
do so because they're engaged in a physically and cognitively challenging task.

My thesis is that the modern Linux command line is a pretty good environment
for working with English prose and prosody, and that maybe this will illuminate
the ways it could be useful in your own work with a computer, whatever that
work happens to be.

terms and definitions
---------------------

What software are we actually talking about when we say "the command line"?

For the purposes of this discussion, we're talking about an environment built
on a very old paradigm called Unix.

-> <img src="images/jp_unix.jpg" height=320 width=470> <-

...except what classical Unix really looks like is this:

-> <img src="images/blinking.gif" width=470> <-

The Unix-like environment we're going to use isn't very classical, really.
It's an operating system kernel called Linux, combined with a bunch of things
written by other people (people in the GNU and Debian projects, and many
others).  Purists will tell you that this isn't properly Unix at all.  In
strict historical terms they're right, or at least a certain kind of right, but
for the purposes of my cultural agenda I'm going to ignore them right now.

-> <img src="images/debian.png"> <-

This is what's called a shell.  There are many different shells, but they
pretty much all operate on the same idea:  You navigate a filesystem and run
programs by typing commands.  Commands can be combined in various ways to make
programs of their own, and in fact the way you use the computer is often just
to write little programs that invoke other programs, turtles-all-the-way-down
style.

The standard shell these days is something called Bash, so we'll use Bash.
It's what you'll most often see in the wild.  Like most shells, Bash is ugly
and stupid in more ways than it is possible to easily summarize.  It's also an
incredibly powerful and expressive piece of software.

get you a shell
---------------

{TODO: Make this section useful.}

twisty little passages
----------------------

Have you ever played a text-based adventure game or MUD, of the kind that
describes a setting and takes commands for movement and so on?  Readers of a
certain age and temperament might recognize the opening of Crowther & Woods'
_Adventure_, the great-granddaddy of text adventure games:

    YOU ARE STANDING AT THE END OF A ROAD BEFORE A SMALL BRICK BUILDING.
    AROUND YOU IS A FOREST.  A SMALL STREAM FLOWS OUT OF THE BUILDING ANd
    DOWN A GULLY.

    > GO EAST

    YOU ARE INSIDE A BUILDING, A WELL HOUSE FOR A LARGE SPRING.

    THERE ARE SOME KEYS ON THE GROUND HERE.

    THERE IS A SHINY BRASS LAMP NEARBY.

    THERE IS FOOD HERE.

    THERE IS A BOTTLE OF WATER HERE.

In much the same way, you can think of the shell as a kind of environment you
inhabit, the same way your character might inhabit an adventure game.  Or as a
sort of vehicle for getting around inside of computers.  The difference is that
instead of navigating around virtual rooms and hallways with commands like
`LOOK` and `EAST`, you navigate between directories by typing commands like
`ls` and `cd notes`:

    $ ls
    code  Downloads  notes  p1k3  photos  scraps  userland-book
    $ cd notes
    $ ls
    notes.txt  sparkfun  TODO.txt

`ls` lists files.  Some files are directories, which means they can contain
other files, and you can step inside of them by typing `cd` (for **c**hange
**d**irectory).

In the Macintosh and Windows world, directories have been called
"folders" for a long time now.  This isn't the _worst_ metaphor for what's
going on, and it's so pervasive by now that it's not worth fighting about.
It's also not exactly a _great_ metaphor, since computer filesystems aren't
built very much like the filing cabinets of yore.  A directory acts a lot like
a container of some sort, but it's an infinitely expandable one which may
contain nested sub-spaces much larger than itself.  Directories are frequently
like the TARDIS: Bigger on the inside.

cat
---

When you're in the shell, you have many tools at your disposal - programs that
can be used on many different files, or chained together with other programs.
They tend to have weird, cryptic names, but a lot of them do very simple
things.  Tasks that might be a menu item in a big program like Word, like
counting the number of words in a document or finding a particular phrase, are
often programs unto themselves.  We'll start with something even more basic
than that.

Suppose you have some files, and you're curious what's in them.  For example,
suppose you've got a list of authors you're planning to reference, and you just
want to check its contents real quick-like.  This is where our friend `cat`
comes in:

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

"Why," you might be asking, "is the command to dump out the contents of a file
to a screen called `cat`?  What do felines have to do with anything?"

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

wildcards
---------

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

There's a problem here.  Our author list is out of order, and thus confusing to
reference.  Fortunately, since one of the most basic things you can do to a
list is to sort it, someone else has already solved this problem for us.
Here's a command that will give us some organization:

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
**k**ey (by default, sort treats whitespace as a division between fields):

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
and "Vanessa".  (Of course, it's still far from perfect, because the
second field in each line isn't necessarily the person's last name.)

options
-------

Above, when we wanted to ask `sort` to behave differently, we gave it what is
known as an option.  Most programs with command-line interfaces will allow
their behavior to be changed by adding various options.  Options usually 
(but not always!) look like `-o` or `--option`.

For example, if we wanted to see just the unique lines, irrespective of case,
for a file called colors:

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

We could write this:

<!-- exec -->

    $ sort -uf colors
    blue
    Green
    RED

<!-- end -->

Here `-u` stands for **u**nique and `-f` stands for **f**old case, which means
to treat upper- and lower-case letters as the same for comparison purposes.  You'll
often see a group of short options following the `-` like this.

uniq
----

Did you notice how Vanessa Veselka shows up twice in our list of authors?
That's useful if we want to remember that she's in more than one category, but
it's redundant if we're just worried about membership in the overall set of
authors.  We can make sure our list doesn't contain repeating lines by using
`sort`, just like with that list of colors:

<!-- exec -->

    $ sort -u -k2 authors_*
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

But there's another approach to this -- `sort` is good at only displaying a line
once, but suppose we wanted to see a count of how many different lists an
author shows up on?  `sort` doesn't do that, but a command called `uniq` does,
if you give it the option `-c` for **c**ount.

`uniq` moves through the lines in its input, and if it sees a line more than
once in sequence, it will only print that line once.  If you have a bunch of
files and you just want to see the unique lines across all of those files, you
probably need to run them through `sort` first.  How do you do that?

<!-- exec -->

    $ sort authors_* | uniq -c
          1 Eden Robinson
          1 Gwendolyn L. Waring
          1 James Tiptree, Jr.
          1 John Brunner
          1 John Ronald Reuel Tolkien
          1 Jo Walton
          1 Miriam Toews
          1 Pat Cadigan
          1 Ursula K. Le Guin
          2 Vanessa Veselka

<!-- end -->

standard IO
-----------

The `|` is called a "pipe".  In the command above, it tells your shell that
instead of printing the output of `sort authors_*` right to your terminal, it
should send it to `uniq -c`.

-> <img src="images/pipe.gif"> <-

Pipes are some of the most important magic in the shell.  When the people who
built Unix in the first place give interviews about the stuff they remember
from the early days, a lot of them reminisce about the invention of pipes and
all of the new stuff it immediately made possible.

Pipes help you control a thing called "standard IO".  In the world of the
command line, programs take **i**nput and produce **o**utput.  A pipe is a way
to hook the output from one program to the input of another.

Unlike a lot of the weirdly named things you'll encounter in software, the
metaphor here is obvious and makes pretty good sense.  It even kind of looks
like a physical pipe.

What if, instead of sending the output of one program to the input of another,
you'd like to store it in a file for later use?

Check it out:

<!-- exec -->

    $ sort authors_* | uniq > ./all_authors
    
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

I like to think of the `>` as looking like a little funnel.  It can be
dangerous -- you should always make sure that you're not going to clobber
an existing file you actually want to keep.

If you want to tack more stuff on to the end of an existing file, you can use
`>>` instead.  To test that, let's use `echo`, which prints out whatever string
you give it on a line by itself:

<!-- exec -->

    $ echo 'hello' > hello_world
    
<!-- end -->

<!-- exec -->

    $ echo 'world' >> hello_world
    
<!-- end -->

<!-- exec -->

    $ cat hello_world
    hello
    world

<!-- end -->

You can also take a file and pull it directly back into the input of a given
program, which is a bit like a funnel going the other direction:

<!-- exec -->

    $ nl < all_authors
         1	Eden Robinson
         2	Gwendolyn L. Waring
         3	James Tiptree, Jr.
         4	John Brunner
         5	John Ronald Reuel Tolkien
         6	Jo Walton
         7	Miriam Toews
         8	Pat Cadigan
         9	Ursula K. Le Guin
        10	Vanessa Veselka

<!-- end -->

`nl` is just a way to **n**umber **l**ines.  This command accomplishes pretty much
the same thing as `cat all_authors | nl`, or `nl all_authors`.  You won't see
it used as often as `|` and `>`, since most utilities can read files on their
own, but it can save you typing `cat` quite as often.

We'll use these features liberally from here on out.

`--help` and man pages
----------------------

You can change the behavior of most tools by giving them different options.
This is all well and good if you already know what options are available,
but what if you don't?

Often, you can ask the tool itself:

    $ sort --help
    Usage: sort [OPTION]... [FILE]...
      or:  sort [OPTION]... --files0-from=F
    Write sorted concatenation of all FILE(s) to standard output.
    
    Mandatory arguments to long options are mandatory for short options too.
    Ordering options:
    
      -b, --ignore-leading-blanks  ignore leading blanks
      -d, --dictionary-order      consider only blanks and alphanumeric characters
      -f, --ignore-case           fold lower case to upper case characters
      -g, --general-numeric-sort  compare according to general numerical value
      -i, --ignore-nonprinting    consider only printable characters
      -M, --month-sort            compare (unknown) < 'JAN' < ... < 'DEC'
      -h, --human-numeric-sort    compare human readable numbers (e.g., 2K 1G)
      -n, --numeric-sort          compare according to string numerical value
      -R, --random-sort           sort by random hash of keys
          --random-source=FILE    get random bytes from FILE
      -r, --reverse               reverse the result of comparisons

...and so on.  (It goes on for a while in this vein.)

If that doesn't work, or doesn't provide enough info, the next thing to try is
called a man page.  ("man" is short for "manual".  It's sort of an unfortunate
abbreviation.)

    $ man sort

    SORT(1)                         User Commands                        SORT(1)



    NAME
           sort - sort lines of text files

    SYNOPSIS
           sort [OPTION]... [FILE]...
           sort [OPTION]... --files0-from=F

    DESCRIPTION
           Write sorted concatenation of all FILE(s) to standard output.

...and so on.  Manual pages vary in quality, and it can take a while to get
used to reading them, but they're very often the best place to look for help.

If you're not sure what _program_ you want to use to solve a given problem, you
might try searching all the man pages on the system for a keyword.  `man`
itself has an option to let you do this - `man -k keyword` - but most systems
also have a shortcut called `apropos`, which I like to use because it's easy to
remember if you imagine yourself saying "apropos of [some problem I have]..."

<!-- exec -->

    $ apropos -s1 sort
    apt-sortpkgs (1)     - Utility to sort package index files
    bunzip2 (1)          - a block-sorting file compressor, v1.0.6
    bzip2 (1)            - a block-sorting file compressor, v1.0.6
    comm (1)             - compare two sorted files line by line
    sort (1)             - sort lines of text files
    tsort (1)            - perform topological sort

<!-- end -->

It's useful to know that the manual represented by `man` has numbered sections
for different kinds of manual pages.  Most of what the average user needs to
know about lives in section 1, "User Commands", so you'll often see the names
of different tools written like `sort(1)` or `cat(1)`.  This can be a good way
to make it clear in writing that you're talking about a specific piece of
software rather than a verb or a small carnivorous mammal.  (I specified `-s1`
for section 1 above just to cut down on clutter, though in practice I usually
don't bother.)

Like other literary traditions, Unix is littered with this sort of convention.
This one just happens to date from a time when the manual was still a physical
book.

wc
--

`wc` stands for **w**ord **c**ount.  It does about what you'd expect - it
counts the number of words in its input.

    $ wc index.md
      736  4117 24944 index.md

736 is the number of lines, 4117 the number of words, and 24944 the number of
characters in the file I'm writing right now.  I use this constantly.  Most
obviously, it's a good way to get an idea of how much you've written.  `wc` is
the tool I used to track my progress the last time I tried National Novel
Writing Month:

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

This kind of thing is trivial, but it comes in handy more often than you might
think.

head, tail, and cut
-------------------

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

tab separated values
--------------------

Notice above how we had to tell `cut` that "fields" in `authors_*` are
delimited by spaces?  It turns out that if you don't use `-d`, `cut` defaults
to using tab characters for a delimiter.

Tab characters are sort of weird little animals.  You can't usually _see_ them
directly -- they're like a space character that takes up more than one space
when displayed.  By convention, one tab is usually rendered as 8 spaces, but
it's up to the software that's displaying the character what it wants to do.

(In fact, it's more complicated than that:  Tabs are often rendered as marking
_tab stops_, which is a concept I remember from 7th grade typing classes, but
haven't actually thought about in my day-to-day life for nearly 20 years.)

Here's a version of our `all_authors` that's been rearranged so that the first
field is the author's last name, the second is their first name, the third is
their middle name or initial (if we know it) and the fourth is any suffix.
Fields are separated by a single tab character:

<!-- exec -->

    $ cat all_authors.tsv
    Robinson	Eden
    Waring	Gwendolyn	L.
    Tiptree	James		Jr.
    Brunner	John
    Tolkien	John	Ronald Reuel
    Walton	Jo
    Toews	Miriam
    Cadigan	Pat
    Le Guin	Ursula	K.
    Veselka	Vanessa

<!-- end -->

That looks kind of garbled, right?  In order to make it a little more obvious
what's happening, let's use `cat -T`, which displays tab characters as `^I`:

<!-- exec -->

    $ cat -T all_authors.tsv
    Robinson^IEden
    Waring^IGwendolyn^IL.
    Tiptree^IJames^I^IJr.
    Brunner^IJohn
    Tolkien^IJohn^IRonald Reuel
    Walton^IJo
    Toews^IMiriam
    Cadigan^IPat
    Le Guin^IUrsula^IK.
    Veselka^IVanessa

<!-- end -->

It looks odd when displayed because some names are at or nearly at 8 characters long.
"Robinson", at 8 characters, overshoots the first tab stop, so "Eden" gets indented
further than other first names, and so on.

Fortunately, in order to make this more human-readable, we can pass it through
`expand`, which turns tabs into a given number of spaces (8 by default):

<!-- exec -->

    $ expand -t14 all_authors.tsv
    Robinson      Eden
    Waring        Gwendolyn     L.
    Tiptree       James                       Jr.
    Brunner       John
    Tolkien       John          Ronald Reuel
    Walton        Jo
    Toews         Miriam
    Cadigan       Pat
    Le Guin       Ursula        K.
    Veselka       Vanessa

<!-- end -->

Now it's easy to sort by last name:

<!-- exec -->

    $ sort -k1 all_authors.tsv | expand -t14
    Brunner       John
    Cadigan       Pat
    Le Guin       Ursula        K.
    Robinson      Eden
    Tiptree       James                       Jr.
    Toews         Miriam
    Tolkien       John          Ronald Reuel
    Veselka       Vanessa
    Walton        Jo
    Waring        Gwendolyn     L.

<!-- end -->

Or just extract middle names and initials:

<!-- exec -->

    $ cut -f3 all_authors.tsv | grep .
    L.
    Ronald Reuel
    K.

<!-- end -->

It probably won't surprise you to learn that there's a corresponding `paste`
command, which takes two or more files and stitches them together with tab
characters.  Let's extract a couple of things from our author list and put them
back together in a different order:

<!-- exec -->

    $ cut -f1 all_authors.tsv > lastnames
    
<!-- end -->

<!-- exec -->

    $ cut -f2 all_authors.tsv > firstnames
    
<!-- end -->

<!-- exec -->

    $ paste firstnames lastnames | sort -k2 | expand -t12
    John        Brunner
    Pat         Cadigan
    Ursula      Le Guin
    Eden        Robinson
    James       Tiptree
    Miriam      Toews
    John        Tolkien
    Vanessa     Veselka
    Jo          Walton
    Gwendolyn   Waring

<!-- end -->

As these examples show, TSV is something very like a primitive spreadsheet:  A
way to represent information in columns and rows.  In fact, it's a close cousin
of CSV, which is often used as a lowest-common-denominator format for
transferring spreadsheets, and which represents data something like this:

    last,first,middle,suffix
    Tolkien,John,Ronald Reuel,
    Tiptree,James,,Jr.

The advantage of tabs is that they're supported by a bunch of the standard
tools.  A disadvantage is that they're kind of ugly and can be weird to deal
with, but they're useful anyway, and character-delimited rows are often a
good-enough way to hack your way through problems that call for basic
structure.

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

now you have n problems: regex and rabbit holes
-----------------------------------------------

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
shell to match groups of files, but for text in general and with more magic.

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
    <tr><td><code>^</code>    </td>  <td>start of a line                     </td></tr>
    <tr><td><code>$</code>    </td>  <td>end of a line                       </td></tr>
    <tr><td><code>[abc]</code></td>  <td>one of a, b, or c                   </td></tr>
    <tr><td><code>[a-z]</code></td>  <td>a character in the range a through z</td></tr>
    <tr><td><code>[0-9]</code></td>  <td>a character in the range 0 through 9</td></tr>

    <tr><td><code>+</code>    </td>  <td>one or more of the preceding thing  </td></tr>
    <tr><td><code>?</code>    </td>  <td>0 or 1 of the preceding thing       </td></tr>
    <tr><td><code>*</code>    </td>  <td>any number of the preceding thing   </td></tr>

    <tr><td><code>(foo|bar)</code></td>  <td>"foo" or "bar"</td></tr>
    <tr><td><code>(foo)?</code></td>     <td>optional "foo"</td></tr>
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

-> ✑ <-

I'll be returning to this theme, but for the time being let's move on.  Now
that we've established, however haphazardly, some of the basics, let's consider
their application to a real-world task.
