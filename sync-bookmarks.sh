#!/bin/bash

for repo in `cat $(dirname $0)/repos.txt`; do
    cd $repo
    
    branches=`hg branches | sed "s/ \+/ /g" | tr " " "=" | tr "\n" " "`
    
    for branch in $branches; do
        name=`echo $branch | cut -d"=" -f1`
        rev=`echo $branch | cut -d"=" -f2 | cut -d":" -f1`
        
        if [ "$name" == "default" ]; then
            name=master
        fi
        
        hg update -r $rev
        hg bookmark -f $name
    done
    
    cd ..
done
