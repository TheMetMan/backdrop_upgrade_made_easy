#!/bin/bash
#
# Script as Step 4 in Upgrading Backdrop to clean up temporary folders
# 
#
PATH=$HOME/.local/bin:$HOME/bin:$PATH
pattern="$1"
result=0
for _dir in "${HOME}"/FG-Docs/public_html/*"${pattern}/web"; do
#for _dir in "${HOME}"/apps/*"${pattern}"; do
	echo "${_dir}"
  cd "${_dir}" || exit
	rm -fr "core_*"
done
exit ${result}
