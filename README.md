userland:  a book about the command line for humans
===================================================

This is the source for some text which can be found here:

[http://p1k3.com/userland-book/](//p1k3.com/userland-book)

...which is probably the best place to read it.

what
----

From the introduction:

> Late last year, [a side trip](//p1k3.com/2013/8/4) into text utilities got me
> thinking about how much my writing habits depend on the Linux command line.
> This struck me as a good hook for talking about the tools I use every day
> with an audience of mixed technical background.
>
> So now I'm writing a (short, haphazard) book.  This isn't a book about system
> administration, or writing big software systems, or becoming a wizard.  I am
> not a wizard, and I don't subscribe to the idea that wizardry is a requirement
> for using these tools.  In fact I barely know what I'm doing most of the time,
> but I still get some stuff done.
>
> My hope herein is to convey something useful to people who use computers every
> day, but for whom the command line environment seems mystifying, obscure, or
> generally uninviting.  I intend to gloss over many complexities in favor of
> demonstrating a rough-and-ready toolset.
>

[p1k3.com/userland-book.git](//p1k3.com/userland-book.git) is the canonical git
repo, but I'm pushing everything to a [GitHub
mirror](https://github.com/brennen/userland-book), and welcome feedback there.

how
---

This is mostly just some Markdown files and a handful of scripts.  Chapters are
listed in a file called `chapters`; each chapter is a directory containing an
`index.md` and any supplemental files.  These are pushed through `render.pl`
and concatenated with `header.html` & `footer.html`.  For convenience, this is
handled by a basic `Makefile`:

    $ make
    cat chapters | xargs ./render.pl | cat header.html - footer.html > index.html

`render.pl` wraps up a library called `Text::Markdown::Discount`, which in turn
wraps up the Discount Markdown parser.  Aside from this, it also generates a
table of contents and expands code of the form

    <!-- exec -->

        $ [some command]

    <!-- end -->

to include the output of the command executed in the directory containing the
rendered file, which is how most of the example commands in the text are
rendered.  In keeping with long tradition, this is done with cheeseball regex
substitution.  **Be aware that, by running make, you are implicitly trusting
most of the commands found in the text to run on your system.**  This is no
weirder than the level of trust extended to most any build process, but I don't
want it to catch anyone by surprise.

There's also a `links.md`, which should contain all links to external
resources.

To build the whole thing without errors, you'd need to be on a system with a
couple of external repos, Bash and the GNU coreutils, and miscellaneous
utilities (notably `cowsay`, `dict`, `figlet`, `aspell`, `curl`, `lynx`, and
`w3m`).  A recent Debian or some derivative would probably work best.  One of
these days I'll wrap up all the dependencies in a package.

author
------

Brennen Bearnes (p1k3.com / @brennen)
