4. script
=========

Back in chapter 1, I said that "the way you use the computer is often just to write
little programs that invoke other programs".  In fact, we've already gone over a
bunch of these.  Grepping through the text of a previous chapter should pull
up some good examples:

<!-- exec -->

    $ grep -E '[a-z]+.*\| ' ../literary_environment/index.md
        $ sort -k2 authors_* | uniq
        $ sort colors | uniq -i -c
        $ sort authors_* | uniq > all_authors
    thing as `cat all_authors | nl`, or `nl all_authors`.  You won't see this as
        $ find ~/p1k3/archives/2010/11 -regextype egrep -regex '.*([0-9]+|index)' -type f | xargs wc -w | grep total
        $ sort authors_* | uniq | wc -l
        $ dict concatenate | head -10
        $ sort colors | uniq -i | tail -1
        $ cut -d' ' -f1 ./authors_* | sort | uniq -ci | sort -n | tail -3
        $ sort -u ./authors_* | cut -d' ' -f1 | uniq -ci | sort -n | tail -3
        $ cat ./authors_* | grep 'Vanessa'

<!-- end -->

None of these one-liners do all that much, but they all take input of one sort
or another and transform it into something new by doing a series of things to
it.  They're little formal sentences describing how to make one thing into
another, which is as good a definition of programming as most.  Or at least
this is a good way to describe programming-in-the-small.  (A lot of the
programs we use day-to-day are more like essays, novels, or interminable
Fantasy series where every character you like dies horribly than they are like
individual sentences.)

One-liners like these are all well and good when you're staring at a terminal,
trying to figure something out - but what about when you've already figured it out and
you want to repeat it in the future?

It turns out that Bash has you covered.  Since shell commands are just text,
they can live in a text file as easily as they can be typed.

learn you an editor
-------------------

We've skirted the topic so far, but now that we're talking about writing out
text files in earnest, you're going to want a text editor.

My editor is where I spend most of my time that isn't in a web browser, because
it's where I write both code and prose.  It turns out that the features which
make a good code editor overlap a lot with the ones that make a good editor of
English sentences.

So what should you use?  Well, there have been other contenders in recent
years, but in truth nothing comes close to dethroning the Great Old Ones of
text editing.  Emacs is a creature both primal and sophisticated, like an
avatar of some interstellar civilization that evolved long before multicellular
life existed on earth and seeded the galaxy with incomprehensible artefacts and
colossal engineering projects.  Vim is like a lovable chainsaw-studded robot
with the most elegant keyboard interface in history secretly emblazoned on its
shining diamond heart.

It's worth the time it takes to learn one of the serious editors, but there are
easier places to start.  Nano, for example, is easy to pick up, and should be
available on most systems.  To start it, just say:

    $ nano file

You should see something like this:

{nano.png}

Arrow keys will move your cursor around, and typing stuff will make it appear
in the file.  This is pretty much like every other editor you've ever used.  If
you haven't used Nano before, that stuff along the bottom of the terminal is a
reference to the most commonly used commands.  `^` is a convention for "Ctrl",
so `^O` means Ctrl-o (the case of the letter doesn't actually matter), which
will save the file you're working on.  Ctrl-x will quit, which is probably the
first important thing to know about any given editor.

d.i.y. utilities
----------------

So back to putting commands in text files.

{much verbiage about scripts to come}

<!-- exec -->

    $ cat okpoems
    #!/bin/bash
    
    # find all the marker files and get the name of
    # the directory containing each
    find ~/p1k3/archives -name 'meta-ok-poem' | xargs -n1 dirname
    
    exit 0

<!-- end -->

<!-- exec -->

    $ ./okpoems
    /home/brennen/p1k3/archives/2013/2/9
    /home/brennen/p1k3/archives/2012/3/17
    /home/brennen/p1k3/archives/2012/3/26

<!-- end -->

<!-- exec -->

    $ cat markpoem
    #!/bin/bash
    
    # $1 is the first parameter to our script
    POEM=$1
    
    # Complain and exit if we weren't given a path:
    if [ ! $POEM ]
    then
      echo 'usage: markpoem <path>'
    
      # Confusingly, an exit status of 0 means to the shell that everything went
      # fine, while any other number means that something went wrong.
      exit 64
    fi
    
    if [ ! -e $POEM ]
    then
      echo "$POEM not found"
      exit 66
    fi
    
    echo "marking $1 an ok poem"
    
    POEM_BASENAME=$(basename $POEM)
    
    # If the target is a plain file instead of a directory, make it into
    # a directory and move the content into $POEM/index:
    if [ -f $POEM ]
    then
      echo "making $POEM into a directory, moving content to"
      echo "  $POEM/index"
      TEMPFILE="/tmp/$POEM_BASENAME.$(date +%s.%N)"
      mv $POEM $TEMPFILE
      mkdir $POEM
      mv $TEMPFILE $POEM/index
    fi
    
    if [ -d $POEM ]
    then
      # touch(1) will either create the file or update its timestamp:
      touch $POEM/meta-ok-poem
    else
      echo "something broke - why isn't $POEM a directory?"
      file $POEM
    fi
    
    # Signal that all is copacetic:
    echo kthxbai
    exit 0

<!-- end -->

These are imperfect, but they were quick to write, they're made out of standard
commands, and I don't yet hate myself for them.  These are all signs that I'm
not totally on the wrong track with the `meta-ok-poem` abstraction, and could
build it into my ongoing writing project.  These scripts would also be easy to
hook into with custom keybindings in my editor.  With a few more lines of code,
I can build a system to wade through the list of candidate files one at a time
and mark the interesting ones.

So what's lacking?  Well, probably a bunch of things, feature-wise.  I can
imagine writing a script to unmark a poem, for example.  That said, there's one
really glaring problem.  "Ok poem" is only one kind of property a blog entry
might possess.  Suppose I wanted a way to express that a poem is terrible?

It turns out I already know how to add properties to an entry.  If I generalize
a little, the tools become much more flexible.

<!-- exec -->

    $ ./addprop /home/brennen/p1k3/archives/2012/3/26 meta-terrible-poem
    marking /home/brennen/p1k3/archives/2012/3/26 with meta-terrible-poem
    kthxbai

<!-- end -->

<!-- exec -->

    $ ./findprop meta-terrible-poem
    /home/brennen/p1k3/archives/2012/3/26

<!-- end -->

`addprop` is only a little different from `markpoem`.  It takes two parameters
instead of one - the target entry and the property to add.  

<!-- exec -->

    $ cat addprop
    #!/bin/bash
    
    ENTRY=$1
    PROPERTY=$2
    
    # Complain and exit if we weren't given a path and a property:
    if [[ ! $ENTRY || ! $PROPERTY ]]
    then
      echo "usage: addprop <path> <property>"
      exit 64
    fi
    
    if [ ! -e $ENTRY ]
    then
      echo "$ENTRY not found"
      exit 66
    fi
    
    echo "marking $ENTRY with $PROPERTY"
    
    # If the target is a plain file instead of a directory, make it into
    # a directory and move the content into $ENTRY/index:
    if [ -f $ENTRY ]
    then
      echo "making $ENTRY into a directory, moving content to"
      echo "  $ENTRY/index"
    
      # Get a safe temporary file:
      TEMPFILE=`mktemp`
    
      mv $ENTRY $TEMPFILE
      mkdir $ENTRY
      mv $TEMPFILE $ENTRY/index
    fi
    
    if [ -d $ENTRY ]
    then
      touch $ENTRY/$PROPERTY
    else
      echo "something broke - why isn't $ENTRY a directory?"
      file $ENTRY
    fi
    
    echo kthxbai
    exit 0

<!-- end -->

Meanwhile, `findprop` is more or less `okpoems`, but with a parameter for the
property to find:

<!-- exec -->

    $ cat findprop
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

