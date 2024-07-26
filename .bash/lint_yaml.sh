#!/usr/bin/env bash

set -o pipefail

errors=0

lint_yaml() {
    for file in $(find . -name '*.yml' -o -name '*.yaml'); do
        echo "Checking $file"
        if ! yamllint "$file"; then
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

lint_yaml
