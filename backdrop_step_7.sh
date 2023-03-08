#!/bin/bash
#
# script to Merge upgrade to Master and Push to Remote
#
PATH=$HOME/.local/bin:$HOME/bin:$PATH
pattern="$1"
result=0
for _dir in "${HOME}"/apps/*"${pattern}"; do
	echo "${_dir}"
        cd "${_dir}" || exit
	echo "Merging to Master"
	git checkout master
	git merge upgrade
	git branch -d upgrade
	git push origin master
	echo ""
done
echo "Now run the Dev and Prod Upgrades one by one"
exit ${result}

