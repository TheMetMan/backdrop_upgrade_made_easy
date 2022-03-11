#!/bin/bash
#
# Script as Step 3 in Upgrading Backdrop
# 
#
PATH=$HOME/.local/bin:$HOME/bin:$PATH
pattern="$1"
result=0
#for _dir in "${HOME}"/FG-Docs/public_html/*"${pattern}"; do
for _dir in "${HOME}"/apps/*"${pattern}"; do
	echo "${_dir}"
        cd "${_dir}"
	git status
	git checkout -b upgrade
	git pull origin master
	./importConfigSync
done
exit ${result}
