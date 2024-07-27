login() {
  AWS_PROFILE=$0

  export AWS_ACCESS_KEY_ID=$(aws configure get ${AWS_PROFILE}.aws_access_key_id)
  echo AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID
  export AWS_SECRET_ACCESS_KEY=$(aws configure get ${AWS_PROFILE}.aws_secret_access_key)
  echo AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY
  export AWS_DEFAULT_REGION=$(aws configure get ${AWS_PROFILE}.aws_region)
  echo AWS_DEFAULT_REGION=$(aws configure get ${AWS_PROFILE}.aws_region)
  aws sts get-caller-identity

  git config --global user.name ""
  git config --global user.email ""

  export GITHUB_TOKEN=$(awk '/machine github.com/{getline; getline; print $2}' ~/.netrc)
  echo GITHUB_TOKEN=$GITHUB_TOKEN
  ssh git@github.com
  export GITLAB_TOKEN=$(awk '/machine gitlab.com/{getline; getline; print $2}' ~/.netrc)
  echo GITLAB_TOKEN=$GITLAB_TOKEN
  ssh git@gitlab.com

}
