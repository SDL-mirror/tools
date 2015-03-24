#!/bin/bash

tools=$(dirname $0)
log=`mktemp`

function check()
{
    $@ >> $log 2>&1
    
    if [ $? != 0 ]; then
        echo "Update failed:"
        cat $log
        rm -f $log
        exit 1
    fi
}

check $tools/pull.sh
check $tools/sync-bookmarks.sh
check $tools/push.sh
rm -f $log
