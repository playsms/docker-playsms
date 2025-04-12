#!/bin/bash

while true; do
    su - playsms -c "/usr/local/bin/playsmsd start >/dev/null 2>&1"
    sleep 60
done
