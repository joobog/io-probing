#!/bin/bash

. /sw/rhel6-x64/tcl/modules-3.2.10/Modules/3.2.10/init/zsh

module load gcc
module load mxm/3.4.3082
module load bullxmpi_mlx/bullxmpi_mlx-1.2.9.2
module load k202107/workbench/git-20181010

../configure \
    --with-md-workbench="/work/ku0598/k202107/git/md-workbench"

cd build
make

