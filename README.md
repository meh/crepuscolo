Crepuscolo - syntax highlighting library for Haskell
====================================================
This library enables you to highlight various programming languages and
provides some heuristics to recognize a language for a file.

The highlighter are extensible and implementable with a simple DSL inspired by
vim's syntax files, if you really want you can write a highlighter which
actually parses the source rather than using regexes all around, but that's
kind of overkill most of the time.

This library will be used in [amanuense][1].

[1]: https://github.com/meh/amanuense
