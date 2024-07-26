#!/usr/bin/env bash

set -o pipefail

errors=0

lint_bash() {
    for file in $(find . -name '*.sh'); do
        echo "Checking $file"
        if ! bash -n "$file"; then
            errors=$((errors + 1))
        fi
    done

    if [ $errors -ne 0 ]; then
        echo "$errors linting errors found."
        exit 1
    else
        echo "All files passed linting."
    fi
}

lint_bash
