#!/bin/bash
#
# script to Upgrade Backdrop and any modules on the Local Servers
#
# 2023-03-06 - Upgraded for bee from drush
#
PATH=$HOME/.local/bin:$HOME/bin:$PATH
pattern="$1"
result=0
TEMP_FOLDER="/dev/shm/backdrop"

for _dir in "${HOME}"/apps/*"${pattern}"; do
	echo "${_dir}"
  cd "${_dir}"
	FOLDER=$(basename "$PWD")
#	echo "${FOLDER}"
	./backupEssentials "${FOLDER}" 
  cd "${_dir}/web"
	echo "Upgrade Core"
	if [ -d "${TEMP_FOLDER}" ]; then
    rm -fr "${TEMP_FOLDER}"
  fi
  mkdir "${TEMP_FOLDER}"
  bee dl-core /dev/shm/backdrop
  # rm -fr core
  mv core "core_${version}"
  rsync -arz "${TEMP_FOLDER}/core" .
  echo ""
	echo "Upgrade Modules & Themes"
	bee update -y
	echo ""
	bee updb -y
  bee cc all
  cd "${_dir}"
	./exportConfigSync
	git add -A
	git commit -am "Upgraded Backdrop Core & Modules as required"
done
echo "Now check that all is well with the site before merging and pushing to dev & prod"
exit ${result}

