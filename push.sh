#!/bin/bash

source $(dirname $0)/common.sh

function body()
{
    check cd $repo
    check -e hg -v push ../$repo-git
    check cd ../$repo-git
    check git push --all origin
    check git push --tags origin
    check cd ..
}

loop
