Build & run the container

    export DOCKER_DEFAULT_PLATFORM=linux/amd64 && docker build -t review .
    
    docker run -v "$(pwd):/usr/dissertation" -it --rm review


# Tool guide

A pymwp installation and a set of examples are preloaded in the container.


# Moscow Problem

    coqc moscow.v
    ocamlbuild exchange.byte && ./exchange.byte

Change allocation (exchange.ml) (L17--18)
    
    let pb = Pair (Pair (n5, n1), n4)
    let pc = Pair (Pair (n7, n3), n6)
    

