                                            ⣀⣤⣴⣶⣶⣦⣄⡀⠀⠀⠀⠀⠀⠀⢀⣤⣶⣶⣶⣦⣤⡀⠀⠀⠀
                                          ⢀⣾⣿⣿⣿⣿⣿⣿⣿⣷⣄⠀⠀⠀⢀⣾⣿⣿⣿⣿⣿⣿⣿⣿⣦⡀ ⠀
                                         ⠀⣾⣿⠟⠋⠉⠀⠀⠉⠙⠻⣿⣷⡀⣰⣿⣿⣿⠟⠉⠀⠀⠀⠈⠙⣿⣷⠀
    ╔═╗┌─┐┌─┐┬  ┬┌─┐┌┬┐                  ⢸⣿⠏⠀⠀⠀⠀⠀⠀⠀⠀⠈⢻⣿⣿⣿⡿⠃⠀⠀⠀⠀⠀⠀⠀⠸⣿⡇
    ╠═╣├─┘├─┘│  │├┤  ││                  ⢸⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣾⣿⣿⡿⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⡇
    ╩ ╩┴  ┴  ┴─┘┴└─┘─┴┘                  ⢸⣿⡆⠀⠀⠀⠀⠀⠀⠀⢀⣾⣿⣿⣿⣧⡀⠀⠀⠀⠀⠀⠀⠀⠀⢰⣿⡇
    ╦┌┬┐┌─┐┬  ┬┌─┐┬┌┬┐                   ⠀⢿⣿⣄⡀⠀⠀⠀⢀⣴⣿⣿⣿⠟⠘⢿⣿⣦⣀⡀⠀⠀⢀⣀⣴⣿⡿⠀
    ║│││├─┘│  ││  │ │                    ⠀⠈⠻⣿⣿⣿⣿⣿⣿⣿⣿⡿⠁⠀⠀⠀⠙⣿⣿⣿⣿⣿⣿⣿⣿⡿⠁⠀
    ╩┴ ┴┴  ┴─┘┴└─┘┴ ┴                    ⠀⠀⠀⠈⠛⠻⠿⠿⠿⠛⠁⠀⠀⠀⠀⠀⠀⠈⠙⠻⠿⠿⠿⠛⠉⠀⠀⠀
    ╔═╗┌─┐┌┬┐┌─┐┬ ┬┌┬┐┌─┐┌┬┐┬┌─┐┌┐┌┌─┐┬
    ║  │ ││││├─┘│ │ │ ├─┤ │ ││ ││││├─┤│
    ╚═╝└─┘┴ ┴┴  └─┘ ┴ ┴ ┴ ┴ ┴└─┘┘└┘┴ ┴┴─┘
    ╔═╗┌─┐┌┬┐┌─┐┬  ┌─┐─┐ ┬┬┌┬┐┬ ┬
    ║  │ ││││├─┘│  ├┤ ┌┴┬┘│ │ └┬┘
    ╚═╝└─┘┴ ┴┴  ┴─┘└─┘┴ └─┴ ┴  ┴⠀




This is a companion artifact for a dissertation by the same name.
The artifact allows re-compiling the dissertation from sources,
inspecting the references that could not be archived elsewhere, and
and running executable examples that appear in the dissertation.

------------------------------------------------------------------------
🐳 Start here: create a Docker environment
------------------------------------------------------------------------

Prerequisites: Docker - https://docs.docker.com/engine/install/

At the unzipped sources root folder, run:

    docker build --platform linux/amd64 . -t rdiss
    docker run -v "$(pwd):/dissertation" -it --rm rdiss

The commands will prepare and launch a virtual environment. All
necessary software is pre-installed in the container.

NOTE: the container is built for amd64 architecture. It can be used
on other hosts, but will run much slower than matching architecture.

------------------------------------------------------------------------
📁 Source code organization
------------------------------------------------------------------------
    .
    ├─ 🗀 code/            : Code listings
    ├─ 🗀 fonts/           : Custom fonts
    ├─ 🗀 latex/           : Custom LaTeX
    ├─ 🗀 pdf/             : Static resources (figures, manuscripts)
    ├─ 🗀 pictures/        : TikZ drawings
    ├─ 🗀 references/      : Bib and indices
    ├─ 🗀 text/            : Dissertation content
    ├─ args.tex            : Template configuration
    ├─ content.tex         : Dissertation sections
    ├─ Dockerfile          : Execution environment
    ├─ LICENSE             : License text
    ├─ main.tex            : The TGS ETD template
    ├─ Makefile            : Build commands
    └─ readme.txt          : Copy of this readme

------------------------------------------------------------------------
🏗️ Compile Dissertation (optional)
------------------------------------------------------------------------

A compiled dissertation is available at following addresses.
(1) TODO

Alternatively, inside the Docker container, re-compile the dissertation
by running:

    make

The command should produce a file named main.pdf at the sources root.

------------------------------------------------------------------------
⚗️ Executable examples
------------------------------------------------------------------------

    Section
    1.2.3.4             Derivations I: Range of Analysis Outcomes
    1.2.3.5 and 2.1.7   Derivations II: Tool User Guide
    1.2.6.3             A simple proof in Rocq
    1.2.6.5.1           Program Equivalence
    1.2.6.5.2           Formally verified leftpad
    1.2.6.6             The Moscow Problem

------------------------------------------------------------------------
### Derivations I: Range of Analysis Outcomes

Example 4: Polynomially bounded program is derivable.

    pymwp --info examples/original_paper/example3_1_b.c

Example 5: Failing program admits no derivation.

    pymwp --info examples/original_paper/example3_1_d.c

Example 6: Derivability in presence of partial derivation failure.

    pymwp --info examples/original_paper/example3_5.c

------------------------------------------------------------------------
### Derivations II: Tool User Guide

Examples 7--11: Run examples as described in the tool guide.

    pymwp examples/basics/assign_expression.c --fin --info --no_time
    pymwp examples/infinite/exponent_2.c --fin --info --no_time
    pymwp examples/not_infinite/notinfinite_3.c --fin --info --no_time
    pymwp examples/infinite/infinite_3.c --fin --info --no_time
    pymwp examples/other/dense_loop.c --fin --info --no_time

The output should match the tool guide. The pymwp version is more recent
than in the guide, which affects some outputs, but not the descriptions
of the analysis.

------------------------------------------------------------------------
### A simple proof in Rocq

Inspect the proof:

    cat code/example.v

Check the proof (with time details):

    coqc code/example.v -time

------------------------------------------------------------------------
### Program Equivalence

Compile the examples:

    (cd code \
     && coqc equiv.v \
     && dafny verify equiv.dfy)

Compiling the Rocq proofs do not print any output.
The dafny verification will print:

    Dafny program verifier finished with 3 verified, 0 errors

------------------------------------------------------------------------
### Formally verified leftpad

Compile the examples:

    (cd code \
     && coqc leftpad.v \
     && coqc "leftpad_ssrefl.v" \
     && dafny verify leftpad.dfy)

Compiling the Rocq proofs do not print any output.
The dafny verification will print:

    Dafny program verifier finished with 2 verified, 0 errors

------------------------------------------------------------------------
### The Moscow Problem

Compile and execute the message exchange:

    (cd code \
     && time coqc moscow.v \
     && ocamlbuild exchange.byte && ./exchange.byte)

Expected output (the times are approximate):

    real	0m28.778s
    user	0m28.010s
    sys	    0m0.763s
    Finished, 8 targets (7 cached) in 00:00:00.
    B sends 4 ==> C got A=2 and B=(5, 1, 4)
    C sends 5 ==> B got A=2 and C=(7, 3, 6)

------------------------------------------------------------------------
                           🏁 FINISH 🇫🇮
------------------------------------------------------------------------