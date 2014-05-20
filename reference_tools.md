reference tools: dict, cal
--------------------------

I'll preface this by saying that, of course, almost anyone who is writing
anything on a computer is going to use Google and Wikipedia, and the answer to
questions like "what does this word mean" or "what day did Easter fall on in
1992" is readily available to all of us.

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

    $ cal
         April 2014       
    Su Mo Tu We Th Fr Sa  
           1  2  3  4  5  
     6  7  8  9 10 11 12  
    13 14 15 16 17 18 19  
    20 21 22 23 24 25 26  
    27 28 29 30           

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

