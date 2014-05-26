8. a miscellany of tools and techniques
=======================================

dict
----

Want to know the definition of a word, or find useful synonyms?

    $ dict concatenate | head -10
    4 definitions found
    
    From The Collaborative International Dictionary of English v.0.48 [gcide]:
    
      Concatenate \Con*cat"e*nate\ (k[o^]n*k[a^]t"[-e]*n[=a]t), v. t.
         [imp. & p. p. {Concatenated}; p. pr. & vb. n.
         {Concatenating}.] [L. concatenatus, p. p. of concatenare to
         concatenate. See {Catenate}.]
         To link together; to unite in a series or chain, as things
         depending on one another.

aspell
------

Need to interactively spell-check your presentation notes?

    $ aspell check presentation

Just want a list of potentially-misspelled words in a given file?

<!-- exec -->

    $ aspell list < index.md | sort | uniq -c | sort -nr | head -5
          7 TOSHOW
          6 aspell
          5 ncal
          4 figlet
          4 del

<!-- end -->

mostcommon
----------

Something like that last sequence sure does seem to show up a lot in my work:
Spit out the _n_ most common lines in the input, one way or another.   Here's
a little script to be less repetitive about it.

<!-- exec -->

    $ aspell list < index.md | ./mostcommon 5
          7 TOSHOW
          6 aspell
          5 ncal
          4 figlet
          4 del

<!-- end -->

This turns out to be pretty simple:

<!-- exec -->

    $ cat ./mostcommon
    #!/usr/bin/env bash
    
    # Optionally specify number of lines to show, defaulting to 10:
    TOSHOW=$1
    if [[ ! $TOSHOW ]]; then
      TOSHOW=10
    fi
    
    # sort and then uniqify STDIN,
    # sort numerically on the first field,
    # chop off everything but $TOSHOW lines of input
    
    sort < /dev/stdin | uniq -c | sort -k1 -nr | head -$TOSHOW

<!-- end -->

Notice, though, that it doesn't handle opening files directly.  If you wanted
to find the most common lines in a file with it, you'd have to say something
like `mostcommon < filename` in order to redirect the file to `mostcommon`'s
standard input.

cal and ncal
------------

Want to know what the calendar looks like for this month?

    $ cal
         April 2014       
    Su Mo Tu We Th Fr Sa  
           1  2  3  4  5  
     6  7  8  9 10 11 12  
    13 14 15 16 17 18 19  
    20 21 22 23 24 25 26  
    27 28 29 30           

How about for September, 1950, in a more compact format?

<!-- exec -->

    $ ncal -m9 1950
        September 1950    
    Su     3 10 17 24   
    Mo     4 11 18 25   
    Tu     5 12 19 26   
    We     6 13 20 27   
    Th     7 14 21 28   
    Fr  1  8 15 22 29   
    Sa  2  9 16 23 30   

<!-- end -->

Need to know the date of Easter this year?

<!-- exec -->

    $ ncal -e
    April 20 2014

<!-- end -->

ptx
---

Want to make a [permuted index][kwic] of some phrase?

<!-- exec -->

    $ echo 'i like american music' | ptx
                                  i like   american music
                                           i like american music
                                       i   like american music
                         i like american   music

<!-- end -->



figlet
------

Need to make ASCII art of some giant letters?

<!-- exec -->

    $ figlet "R T F M"
     ____    _____   _____   __  __ 
    |  _ \  |_   _| |  ___| |  \/  |
    | |_) |   | |   | |_    | |\/| |
    |  _ <    | |   |  _|   | |  | |
    |_| \_\   |_|   |_|     |_|  |_|
                                    

<!-- end -->

cowsay
------

How about ASCII art of a <del>cow</del> dragon saying something?

<!-- exec -->

    $ cowsay -f dragon "RTFM, man"
     ___________
    < RTFM, man >
     -----------
          \                    / \  //\
           \    |\___/|      /   \//  \\
                /0  0  \__  /    //  | \ \    
               /     /  \/_/    //   |  \  \  
               @_^_@'/   \/_   //    |   \   \ 
               //_^_/     \/_ //     |    \    \
            ( //) |        \///      |     \     \
          ( / /) _|_ /   )  //       |      \     _\
        ( // /) '/,_ _ _/  ( ; -.    |    _ _\.-~        .-~~~^-.
      (( / / )) ,-{        _      `-.|.-~-.           .~         `.
     (( // / ))  '/\      /                 ~-. _ .-~      .-~^-.  \
     (( /// ))      `.   {            }                   /      \  \
      (( / ))     .----~-.\        \-'                 .~         \  `. \^-.
                 ///.----..>        \             _ -~             `.  ^-`  ^-_
                   ///-._ _ _ _ _ _ _}^ - - - - ~                     ~-- ,.-~
                                                                      /.-~

<!-- end -->
