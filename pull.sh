#!/bin/bash

source $(dirname $0)/common.sh

function body()
{
    check cd $repo
    check hg pull
    check cd ..
}

loop
