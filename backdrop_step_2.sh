#!/bin/bash
#
# Script for Step 2 in Backdrop Upgrade
# Script to run on all Backdrop Production Sites
# Script to exportConfigSync, git commit and push current Production to git remote master prior to Upgrade
#
# cycle through all Prod Sites
PATH=$HOME/.local/bin:$HOME/bin:$PATH
pattern="$1"
for _dir in "${HOME}"/apps/*"${pattern}"*; do
	echo "${_dir}"
	cd "${_dir}" || exit
	git status
	./exportConfigSync
	git add -A
	git commit -am "Prior to upgrade using Ansible"
	git status
	git push origin master
done

