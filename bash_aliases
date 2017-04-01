# a file of bash aliases created by me (vogelari) for workflow optimization
MYALIASES=("cscopesetup, cfind, cherry-pick-from, hex_to_str, mark, jump")

# generic cscope setup.  find all files ending in .c or .h
alias cscopesetup='find . -name "*\.[ch]" -print > cscope.files; find . -name "*\.[ch]" | xargs etags -a'

# run a command with the output of previous command
# this is really just a nice xargs wrapper
# XXX: not tested
# arguments
#       $1 :   command to run
#       $2 :   line of output to use
function use_prev_n {
    touse=$(fc -e : -1 | head -n $2)
    echo "touse: $touse"
    fc -e : -1 | head -n "$2" | tail -n 1 | xargs "$1"
}


# convert hex to string.
# Useful for authlog reading
function hex_to_str {
    echo "$1" | xxd -r -p
    echo ""
}


# use with findngrep <files to search pattern> <pattern to find in files>
# not working right now
function findngrep {
    echo 'find . -name "$1" | xargs grep -nH "$2"'
	find . -name "$1" | xargs grep -nH "$2";
}

#grep all .c, .h files in the current directory
function cfind {
    echo "find . -name '*.[ch]' | xargs grep $1"
    find . -name "*.[ch]" | xargs grep "$1"
}

#shorthand for tmux a -t $session
function ta {
    tmux a -t $1
}

# function to cherry-pick a commit from another directory.  Useful for pulling
# Commits from another develroot.  Usage:
# cherry-pick-from <directory> <commit sha>
function cherry-pick-from {
    git --git-dir="$1"/.git format-patch -k -1 --stdout "$2" | git am -3 -k
}

#stupid shortcuts to make life easier (ie forget about flags)
alias cpr='cp -r'

### non-functional aliases to keep track of tools:
#python pep8 style checker
#docs: https://flake8.readthedocs.org/en/latest/
#alias flake8='flake8'

export MARKPATH=$HOME/.marks
function jump {
    cd -P "$MARKPATH/$1" 2>/dev/null || echo "No such mark: $1"
}

function mark {
    mkdir -p "$MARKPATH"; ln -s "$(pwd)" "$MARKPATH/$1"
}

function unmark {
    rm -i "$MARKPATH/$1"
}

function marks {
    ls -l "$MARKPATH"| sed 's/  / /g' | cut -d' ' -f9- | sed 's/ -/\t-/g' && echo
}

# from kentf
ggrep() {
    local c
    local depth=50
    local pattern
    local res
    local only1=true
    local usage="ggrep [ -a ] [ -<n> ] pattern"

    while [ $# -gt 0 ]; do
        case $1 in
        -a) only1=false
            shift
            ;;
        -[0123456789]*)
            depth=$1
            shift
            ;;
        --) shift
            break
            ;;
        -*|?)  echo "$usage" 1>&2
            return 1
            ;;
        *)  break
            ;;
        esac
    done

    if [ $# -ne 1 ]; then
        echo "$usage" 1>&2
        return 1
    fi

    pattern="$1"

    for c in `git log --abbrev-commit --decorate --pretty=format:'%h' -$depth`; do
        if res=`git grep -ne "$pattern" $c`; then
            echo $res
            $only1 && break
        fi
    done
}
