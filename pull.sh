#!/bin/bash

for repo in `cat $(dirname $0)/repos.txt`; do
    cd $repo
    hg pull
    cd ..
done
