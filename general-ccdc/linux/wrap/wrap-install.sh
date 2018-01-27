#!/bin/sh
# replaces binaries in $PATH with symlinks to wrap.sh

truth=/usr/lib/bin
wrap_location="/usr/bin/wrap.sh"
default_replace="nc bash sh python python2 python3 ruby"

wrapify () {
    cmd="$0"
    if which $0; then
        cmd_origin="$(which "$cmd")"
        echo "wrapping $cmd_origin -> $truth/$cmd"
        mv "$cmd_origin" "$truth/"
        ln -s "$wrap_location" "$cmd_origin"
    else
        echo "skipped $cmd: not found in PATH $PATH"
    fi
}

main () {
    if [ "$#" -gt 0 ]; then
        REPLACE="$@"
    else
        REPLACE="$default_replace"
    fi

    for command_name in $REPLACE; do
        wrapify $command_name
    done
}

main "$@"
