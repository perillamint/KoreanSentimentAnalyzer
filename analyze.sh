#!/bin/bash
DATADIR='../data-sts'
TARGETDIR='../data-out'
DATALIST=$(ls "$DATADIR")


PIDS=""

function cleanup {
    IFS=' '
    for i in $PIDS; do
        kill "$i"
    done
}

trap cleanup SIGHUP SIGINT SIGTERM

PORTIDX=0

IFS=$'\n'
for i in $DATALIST; do
    mkdir -p "$TARGETDIR/$i"
    node analyzer.js localhost $((7000 + $PORTIDX))  2010-01-01 2021-12-31 "$DATADIR/$i" "$TARGETDIR/$i" &
    PIDS="$! $PIDS"
    PORTIDX=$(($PORTIDX + 1))
done

IFS=' '
for i in $PIDS; do
    wait "$i"
done

