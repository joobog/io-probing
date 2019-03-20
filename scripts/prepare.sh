#!/bin/bash

. ./config.sh

VAL=0

for FS in "${!DIRS[@]}"; do
	echo "Initializing ${DIRS[$FS]}"
	set -x
    mpiexec -n 1 $IO_PROBING -i posix -P $WORKING_SET -D 1 -I 1 -1  --run-info-file=mdtest.stat$VAL --ra-enable --ra-file "${DIRS[$FS]}/test.bin" --ra-count $COUNT -- -D "${DIRS[$FS]}/md" &
	set +x
	VAL=$(($VAL+1))
done

