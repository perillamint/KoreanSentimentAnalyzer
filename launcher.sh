#!/bin/bash

source venv/bin/activate

PIDS=""

function cleanup {
    for i in $PIDS; do
        kill "$i"
    done
}

trap cleanup SIGHUP SIGINT SIGTERM

for i in {0..11}; do
    python3 morphemeServer.py 127.0.0.1 $(("7000" + "$i")) &
    PIDS="$! $PIDS"
done

for i in $PIDS; do
    wait "$i"
done
