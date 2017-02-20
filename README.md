# Requirements for the Servant tutorial at Bobkonf 2017

I will be using:

- GHC 8.0.2
- Servant 0.9.x

In essence, you should be safe with [LTS 8][LTS8].

While the exact packages we will need depend somewhat on where the questions
and discussion will take us, I've tried to prepare a probable Cabal package
specification and a `stack.yaml` as well as a trivial `cabal.project` so that
everyone can use their favourite package management tool.

So if you can install the dependencies of the (empty) package at

  https://github.com/kosmikus/servant-bobkonf-2017

then everything should be fine. If you want to use other versions
of packages (e.g. Servant 0.10), that's probably going to be fine,
but it's your risk to take.

[LTS8]: https://www.stackage.org/lts-8.1
