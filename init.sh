#!/bin/bash

sdlbase="https://hg.libsdl.org/"
gitbase="ssh://git@github.com/SDL-mirror/"

for repo in `cat $(dirname $0)/repos.txt`; do
    hg clone $sdlbase$repo
    mkdir $repo-git
    cd $repo-git
    git init --bare
    git remote add origin $gitbase$repo
    cd ..
done
