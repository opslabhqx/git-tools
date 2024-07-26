#!/usr/bin/env bash

set -o errexit -o pipefail

function git_pull_all() {
    for dir in ./repositories/*/; do
        cd "$dir" || exit
        if [ -d ".git" ]; then
            echo "git pull $dir"
            git pull
        else
            echo "$dir is not a git repository. Skipping."
        fi
        cd - > /dev/null
    done
}

git_pull_all
