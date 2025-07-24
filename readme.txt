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
    ╔═╗┌─┐┌┬┐┌─┐┬  ┌─┐─┐ ┬ ┬┌┬┐┬ ┬
    ║  │ ││││├─┘│  ├┤ ┌┴┬┘ │ │ └┬┘
    ╚═╝└─┘┴ ┴┴  ┴─┘└─┘┴ └─ ┴ ┴  ┴⠀



This is a companion artifact for a dissertation by the same name.
The artifact allows re-compiling the dissertation from sources,
running all executable examples that appear in the dissertation, and
inspecting the references that could not be archived elsewhere.

------------------------------------------------------------------------
🐳  Getting Started — Create a Docker Environment
------------------------------------------------------------------------

PREREQUISITES
* Docker - https://docs.docker.com/engine/install/
* Operating system - any Docker-compatible OS
* Internet - only container pull/build requires the host to be online.
* Memory - container size is be approx. 8 GB

STANDARD SETUP
Launch a virtual execution environment. On some machines you may need
sudo. All necessary software is pre-installed in the container.

    docker pull --platform=linux/amd64 ghcr.io/nkrusch/dissertation:artifact
    docker run --name dimage -it --rm ghcr.io/nkrusch/dissertation:artifact

NOTES
* The container expects an amd64/x86 architecture.
* It can be run on other architectures (arm), but will run slower.
* The container has been tested on macOS (amd64-darwin, arm64-darwin).
* The container has been tested on Linux (amd64, Ubuntu 22.04).
* The docker prerequisite cannot be substituted with podman.

ALTERNATIVE SETUP (optional)
If you prefer to build the container, instead of pulling from ghcr.io,
run at unzipped sources root:

    docker build --platform=linux/amd64 . -t dimage
    docker run --name dimage -it --rm dimage

Building a new container takes ~10-20 minutes.

------------------------------------------------------------------------
📁  Source Code Organization
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
    ├─ main.tex            : The Augusta University TGS ETD template
    ├─ Makefile            : Build commands
    └─ readme.txt          : This readme

------------------------------------------------------------------------
🏗️  Compile the Dissertation (optional)
------------------------------------------------------------------------

A pre-compiled dissertation is available at following addresses:

(1) TODO

Alternatively, compile the dissertation by running:

    make full -j ?

where ? is the number of available cores. The compilation takes about
2--10 minutes. It generates a file main.pdf. To view this file, run the
following command in a separate terminal, outside the container:

    docker cp dimage:/usr/dissertation/main.pdf .

------------------------------------------------------------------------
⚗️  Executable Examples
------------------------------------------------------------------------

    SECTION             DESCRIPTION
    1.2.3.4             Derivations I: Range of Analysis Outcomes
    1.2.3.5 and 2.1.7   Derivations II: Tool User Guide
    1.2.6.3             A simple proof in Rocq
    1.2.6.5.1           Program Equivalence
    1.2.6.5.2           Formally verified leftpad
    1.2.6.6             The Moscow Problem

------------------------------------------------------------------------
DERIVATIONS I: RANGE OF ANALYSIS OUTCOMES

Running the examples shows that the automated analysis ends with the
same result as the manual derivation. The automatic analysis omits
mwp-bounds if a variable's only dependency is its input, i.e., X' ≤ X
results will not be displayed.

Example 4: Polynomially bounded program is derivable.

    pymwp --info examples/original_paper/example3_1_b.c

Example 5: Failing program admits no derivation.

    pymwp --info examples/original_paper/example3_1_d.c

Example 6: Derivability in presence of partial derivation failure.

    pymwp --info examples/original_paper/example3_5.c

------------------------------------------------------------------------
DERIVATIONS II: TOOL USER GUIDE

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
A SIMPLE PROOF IN ROCQ

Inspect the proof:

    cat code/example.v

Check the proof (with time details):

    coqc code/example.v -time

------------------------------------------------------------------------
PROGRAM EQUIVALENCE

Compile the examples:

    (cd code \
     && coqc equiv.v \
     && dafny verify equiv.dfy)

Compiling the Rocq proofs do not print any output.
The dafny verification will print:

    Dafny program verifier finished with 3 verified, 0 errors

------------------------------------------------------------------------
FORMALLY VERIFIED LEFTPAD

Compile the examples:

    (cd code \
     && coqc leftpad.v \
     && coqc "leftpad_ssrefl.v" \
     && dafny verify leftpad.dfy)

Compiling the Rocq proofs do not print any output.
The dafny verification will print:

    Dafny program verifier finished with 2 verified, 0 errors

------------------------------------------------------------------------
THE MOSCOW PROBLEM

Compile and execute the message exchange:

    (cd code \
     && time coqc moscow.v \
     && ocamlbuild exchange.byte && ./exchange.byte)

Expected output (the times are approximate):

    real    0m28.778s
    user    0m28.010s
    sys     0m0.763s
    Finished, 8 targets (7 cached) in 00:00:00.
    B sends 4 ==> C got A=2 and B=(5, 1, 4)
    C sends 5 ==> B got A=2 and C=(7, 3, 6)

------------------------------------------------------------------------
📜️  Archival
------------------------------------------------------------------------

This artifact is archived at: https://doi.org/10.5281/zenodo.15288398

END.
