#!/bin/bash

sdlbase="https://hg.libsdl.org/"
ghbase="ssh://git@github.com/SDL-mirror/"

for repo in `cat $(dirname $0)/repos.txt`; do
    hg clone $base$repo
    mkdir $repo-git
    cd $repo-git
    git init --bare
    git remote add origin $ghbase$repo
    cd ..
done
