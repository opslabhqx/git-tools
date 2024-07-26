#!/usr/bin/env bash

set -o errexit -o pipefail

function define_env() {
    if [ -f .env ]; then
        echo "Exporting .env file..."
        while IFS= read -r line; do
            if [[ "$line" == *"="* ]]; then
                export "$line"
                echo "$line"
            fi
        done < .env
    fi
}

git_clone_all() {
    WORKDIR="./repositories"
    mkdir -p ${WORKDIR}
    page=1
    while :
    do
      response=$(curl -s -H "Authorization: token ${GITHUB_TOKEN}" \
        "https://api.github.com/orgs/${GITHUB_ORG_NAME}/repos?per_page=100&page=${page}")
      repos=$(echo ${response} | jq -r '.[].clone_url')
      if [[ -z "${repos}" ]]; then
        break
      fi
      echo "${repos}" | while read repo; do
        repo_name=$(basename ${repo} .git)
        repo_dir="${WORKDIR}/${repo_name}"
        if [ -d "${repo_dir}" ]; then
          echo "Skipping ${repo_name}, directory already exists."
        else
          echo "Cloning ${repo}..."
          git clone ${repo} ${repo_dir}
        fi
      done
      ((page++))
    done
}

define_env
git_clone_all
