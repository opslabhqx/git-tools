#!/usr/bin/env bash

set -o errexit -o pipefail

function git_commit_all() {
    for dir in ./repositories/*/; do
        cd "$dir" || exit
        if [ -d .git ]; then
            if git diff --quiet; then
                echo "No changes in $dir. Skipping."
            else
                git add .
                git commit -m "$COMMIT_MESSAGE"
                git push
            fi
        else
            echo "$dir is not a git repository. Skipping."
        fi
        cd - > /dev/null
    done
}

git config --global user.name
git config --global user.email

git config user.name
git config user.email

COMMIT_MESSAGE="Project Update"

echo COMMIT_MESSAGE=$COMMIT_MESSAGE

git_commit_all
