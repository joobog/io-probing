#!/bin/bash

cd build
rm md -r
mpiexec -n 1 ./src/io-probing -i posix -P 10 -D 10 -I 1 -R 1 -1 -- -D ./md
mpiexec -n 1 ./src/io-probing -i posix -P 10 -D 10 -I 1 -R 1 -2 -- -D ./md
#mpiexec -n 1 ./src/io-probing -P 10 -D 10 -I 1 -R 1 -2

