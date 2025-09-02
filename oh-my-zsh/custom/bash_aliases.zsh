###################################
# Bash aliases
###################################
alias ls='ls -aGFh'
alias findTemp='echo "sudo powermetrics --samplers smc -i1 -n1" && sudo powermetrics --samplers smc -i1 -n1'
# Other Temperature: sudo powermetrics|grep -i "CPU die temperature" && sudo powermetrics|grep -i "GPU die temperature"
alias findFile='echo "find . -name <FILE_NAME>"'
alias findPattern='echo "find . -type f -name *.<EXT>"'
alias findDir='echo "find . -type d -name <DIR_NAME>"'
alias fileSize='echo "du -sh <FILE_OR_DIR>"'
alias brew_updateall='brew update && brew upgrade'
alias lmk='say I have completed my tasks. Look at what I accomplished!'
alias plz='sudo !!'
# vimdiff <(git show origin/master:path/to/file) <(cat path/to/other/file)
# alias findAlias='echo "which ls, aliased to ls -lAh, grep -r ` ls -lAh` ~/.oh-my-zsh/"'

#===   FUNCTION   ===============================
#          NAME: kill_node
#   DESCRIPTION: Kills all node processes on a given port
#   PARAMETER 1: Port number to kill the process on
#==================================
kill_node () {
    if [!$1]; then
        echo "Killing all node processes"
        echo "killall -9 node"
        killall -9 node
    else
        local __port="$1"
        echo "Killing process on Port $__port"
        echo "lsof -n -i4TCP:$__port | grep LISTEN | tr -s ' ' | cut -f 2 -d ' ' | xargs kill -9"
        lsof -n -i4TCP:$__port | grep LISTEN | tr -s ' ' | cut -f 2 -d ' ' | xargs kill -9
    fi
}

#===   FUNCTION   ===============================
#          NAME: findFiles
#   DESCRIPTION: Finds all files by a particular name or type and outputs it
#   PARAMETER 1: Whether to search by name or by type
#   PARAMETER 2: The name/type to search by
#   PARAMETER 3: The folder to start the search in. It does not work with folders with special characters in the name
#==================================
findFiles () {
    local __filePattern="\"$1\""

    if [ $2 ]; then
        local __startDir="$2"
    else
        local __startDir="~"
    fi

    echo "Search for: $__filePattern"
    echo "Search from: $__startDir"

    echo "find $__startDir -type f -name $__filePattern"
    find $__startDir -type f -name "$__filePattern"
}

