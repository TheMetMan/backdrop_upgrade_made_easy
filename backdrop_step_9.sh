#!/bin/bash
#
# Script as Step 9 in Upgrading Backdrop
# 
#
PATH=$HOME/.local/bin:$HOME/bin:$PATH
patterns=(dev prod)
result=0
for pattern in "${patterns[@]}"; do
    for _dir in "${HOME}"/apps/*"${pattern}"; do
	# echo "Pattern = ${pattern}"
	echo "Directory = ${_dir}"
        cd "${_dir}"
	git status
	git checkout master
	git merge upgrade
	git branch -d upgrade
    done
done
exit ${result}
