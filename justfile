# prints this menu
default:
    @just --list

# format source tree
fmt:
    treefmt

# run app
run:
    dune exec bin/main.exe
