function cd()
{
    builtin cd $@
    echo "Working directory now $PWD"
}

function check()
{
    if [ "$1" == "-e" ]; then
        ignore=true
        
        shift
    else
        ignore=false
    fi
    
    echo "Executing \"$@\""
    $@
    
    err=$?
    
    if [ $err != 0 ]; then
        echo -n "Exited with $err"
        
        if [ "$ignore" != "true" ]; then
            echo
            exit 1
        else
            echo ".. ignoring"
        fi
    fi
}

function loop()
{
    for repo in `cat $(dirname $0)/repos.txt`; do
        body
    done
}
