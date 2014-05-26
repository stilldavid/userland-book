7. the command line and the web
===============================

Web browsers are really complicated these days.  They're full of rendering
engines, audio and video players, programming languages, development tools,
databases --- you name it, and there's a fair chance it's in there somewhere.
The modern web browser is kitchen sink software, and to make matters worse, it
is _totally surrounded_ by technobabble.  It can take _years_ to come to terms
with the ocean of words about web stuff and sort out the meaningful ones from
the snake oil and bureaucratic mysticism.

All of which can make the web itself seem like a really complicated landscape,
and obscure the simplicity of its basic design, which is this:

Some programs pass text around to one another.

The gist of it is that the web is made out of URLs, "Uniform Resource
Locators", which are paths to things.  If you squint, these look kind of like
paths to files on your filesystem.  When you visit a URL in your browser, it
asks a server for a certain path, and the server gives it back some text.  When
you click a button to submit a form, your browser sends some text to the server
and waits to see what it says back.

reading the web
---------------

Let's illustrate this.  I've written a really simple web page that lives at
[`http://p1k3.com/hello_world.html`](http://p1k3.com/hello_world.html).

    $ curl 'http://p1k3.com/hello_world.html'
    <html>
      <head>
        <title>hello, world</title>
      </head>
    
      <body>
        <h1>hi everybody</h1>
    
        <p>How are things?</p>
      </body>
    </html>

`curl` is a program with lots and lots of features --- it too is a little bit of
a kitchen sink --- but it has one core purpose, which is to grab things from
URLs and spit them back out.  It's a little bit like `cat` for things on the
web.  Try the above command with just about any URL you can think of, and
you'll probably get _something_ back.  Let's try this book:

    $ curl 'http://p1k3.com/userland-book/' | head
    <!DOCTYPE html>
    <html lang=en>
    <head>
      <meta charset="utf-8">
      <title>userland: a book about the command line for humans</title>
      <link rel=stylesheet href="userland.css" />
      <script src="js/jquery.js" type="text/javascript"></script>
    </head>
    
    <body>

`hello_world.html` and `userland-book` are both HyperText Markup Language.
HTML has been around for quite a while now, and it's undergone a huge amount of
politicking in the last 20 years, but at heart it still looks a lot [like it
did in 1991](http://info.cern.ch/hypertext/WWW/TheProject.html).

The basic idea is that the contents of a web page are marked up with tags.
A tag looks like this:

    <title>hi!</title> -,
     |     |            |
     |     `- content   |
     |                  `- closing tag
     `-opening tag

Sometimes you'll see tags with what are known as "attributes":

    <a href="http://p1k3.com/userland-book">userland</a>

This is how links are written in HTML.  `href="..."` tells the browser where to
go when the user clicks on "userland".

Tags are a way to describe not so much what something should _look like_ as
what something _means_.  Browsers are, in large part, big collections of
knowledge about the meanings of tags and ways to represent those meanings.

While the browser you use day-to-day is (probably) a graphical interface and
does all sorts of things impossible to render in a terminal, some of the
earliest web browsers were entirely text-based, and text-mode browsers still
exist.  Lynx, which originated at the University of Kansas in the early 1990s,
is still actively maintained:

    $ lynx -dump 'http://p1k3.com/userland-book/' | head
                                        userland
         __________________________________________________________________
    
                     [1]# a book about the command line for humans
    
       Late last year, [2]a side trip into text utilities got me thinking
       about how much my writing habits depend on the Linux command line. This
       struck me as a good hook for talking about the tools I use every day
       with an audience of mixed technical background.
    
If you invoke Lynx without any options, it'll start up in interactive mode, and
you can navigate between links with the arrow keys.  `lynx -dump` spits a
rendered version of a page to standard output, with links annotated in square
brackets and printed as footnotes.  Another useful option here is `-listonly`,
which will print just the list of links contained within a page:

    $ lynx -dump -listonly 'http://p1k3.com/userland-book/' | head
    
    References
    
       2. http://p1k3.com/2013/8/4
       3. http://p1k3.com/userland-book.git
       4. https://github.com/brennen/userland-book
       5. http://p1k3.com/userland-book/
       6. https://twitter.com/brennen
       9. http://p1k3.com/userland-book/#a-book-about-the-command-line-for-humans
      10. http://p1k3.com/userland-book/#copying

An alternative to Lynx is w3m, which copes a little more gracefully with the
complexities of modern web layout.

    $ w3m -dump 'http://p1k3.com/userland-book/' | head
    userland
    
    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    
    # a book about the command line for humans
    
    Late last year, a side trip into text utilities got me thinking about how much
    my writing habits depend on the Linux command line. This struck me as a good
    hook for talking about the tools I use every day with an audience of mixed
    technical background.

Neither of these tools are going to replace enormously capable applications
like Chrome or Firefox, but they have their place in the toolbox, and help to
demonstrate how the web is built (in part) on principles we've already seen at
work.

writing the web
---------------

Most of the web that you interact with is generated by software that pulls data
out of databases and stitches it together into something your browser will
recognize, but it's still entirely possible to write complete HTML documents in
your text editor of choice.

{more to come}

writing the web, easier
-----------------------

I'm pretty comfortable writing HTML by hand.  It's part of my day job, and I've
been doing it for quite a while now.  

{more to come}
