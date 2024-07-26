.DEFAULT_GOAL := help
.PHONY: help files

help:
	@echo "Usage: make [TARGET]"
	@echo "Targets:"
	@echo "git-clone           Clone all Repositories"
	@echo "git-commit          Commit all Repositories"
	@echo "git-pull            Pull all Repositories"
	@echo "lint-bash           Check all Bash files"
	@echo "lint-yaml           Check all YAML files"

files:
	@find . -path './.git' -prune -o -ls > FILES

git-clone:
	@chmod +x ./.bash/git_clone_all.sh
	@bash ./.bash/git_clone_all.sh

git-pull:
	@chmod +x ./.bash/git_pull_all.sh
	@bash ./.bash/git_pull_all.sh

git-commit:
	@chmod +x ./.bash/git_commit_all.sh
	@bash ./.bash/git_commit_all.sh

lint-bash:
	@chmod +x ./.bash/lint_bash.sh
	@bash ./.bash/lint_bash.sh

lint-yaml:
	@chmod +x ./.bash/lint_yaml.sh
	@bash ./.bash/lint_yaml.sh
