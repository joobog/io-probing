#!/bin/bash

declare -A DIRS
DIRS["lustre01"]="/mnt/lustre01/work/ku0598/k202107/experiments"
DIRS["lustre02"]="/mnt/lustre02/work/ku0598/k202107/experiments"

IO_PROBING="./build/src/io-probing"
WORKING_SET=100000
COUNT=$((128 * 1024)) # 128 GB file
