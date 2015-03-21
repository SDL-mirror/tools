#!/bin/bash

for repo in `cat $(dirname $0)/repos.txt`; do
    cd $repo
    hg -v push ../$repo-git
    cd ..
    #TODO: push git repo
    cd $repo-git
    git push --all origin
    git push --tags origin
    cd ..
done
