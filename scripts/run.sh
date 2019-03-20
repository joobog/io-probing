#!/bin/bash

. ./config.sh

PROCS=( )

function finish {
    for PROC in ${PROCS[@]}; do
		echo "Killing $PROC"
        kill $PROC
    done
}
trap finish EXIT


VAL=0

[[ ! -d output/ ]] && mkdir output

for FS in "${!DIRS[@]}"; do
	FILE=output/$HOSTNAME-$FS-$(date -I).txt
    mpiexec -n 1 $IO_PROBING -i posix -P $WORKING_SET -D 1 -I 1 -R -1 -2  --run-info-file=mdtest.stat$VAL --ra-enable --ra-file "${DIRS[$FS]}/test.bin" --ra-count $COUNT -- -D "${DIRS[$FS]}/md" &>> $FILE &
	PID=$!
    echo -e "Running benchmark on ${DIRS[$FS]}"
	printf "%10s: %d\n" "PID" $PID
	printf "%10s: %s\n" "FS" $FS
	printf "%10s: %s\n" "OUTPUT" $FILE
    PROCS=( ${PROCS[@]} $PID )
    VAL=$(($VAL+1))
done

read -n 1 -s -r -p "Press any key to cancel"
echo ""
