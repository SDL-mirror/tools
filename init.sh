#!/bin/bash

sdlbase="https://hg.libsdl.org/"
gitbase="ssh://git@github.com/SDL-mirror/"

source $(dirname $0)/common.sh

function body()
{
    if [ -e $repo ]; then
        echo "$repo seems to have been initialized already"
        return
    fi
    
    check hg clone $sdlbase$repo
    check echo -e "[extensions]\nhggit =" >> $repo/.hg/hgrc
    check mkdir $repo-git
    check cd $repo-git
    check git init --bare
    check git remote add origin $gitbase$repo
    check cd ..
}

loop
