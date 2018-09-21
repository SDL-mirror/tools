#!/bin/bash

tools=$(dirname $0)
log=`mktemp`

if [ "$1" == "-v" ]; then
    function check()
    {
        echo $@
        $@
        
        ret=$?
        
        if [ $ret != 0 ]; then
            echo "Exited with code $ret"
            exit 1
        fi
    }
else
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
fi

check $tools/pull.sh
check $tools/sync-bookmarks.sh
check $tools/push.sh
check python2 $tools/close-pulls.py
rm -f $log
