#!/bin/bash
#
# script to warn if there re any sites with update branch
# passing the pattern as an argument
# run from the playbooks for step 1
#
PATH=$HOME/.local/bin:$HOME/bin:$PATH
pattern="$1"
result=0
for _dir in "${HOME}"/apps/*"${pattern}"; do
        cd "${_dir}"
        branch=$(git branch | grep up)
        if [[ $branch ]]; then
           echo "${_dir}"
           echo "branch found."
           result=1
fi
done
exit ${result}

