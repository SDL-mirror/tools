#!/bin/bash

source $(dirname $0)/common.sh

function body()
{
    check cd $repo
    
    branches=`hg branches | sed "s/ \+/ /g" | tr " " "=" | tr "\n" " "`
    
    for branch in $branches; do
        name=`echo $branch | cut -d"=" -f1`
        rev=`echo $branch | cut -d"=" -f2 | cut -d":" -f1`
        
        if [ "$name" == "default" ]; then
            name=master
        fi
        
        check hg update -r $rev
        check hg bookmark -f $name
    done
    
    check cd ..
}

loop
