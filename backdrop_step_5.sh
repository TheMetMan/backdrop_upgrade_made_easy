#!/bin/bash
#
# script to Upgrade Backdrop and any modules on the Local Servers
#
# 2023-03-06 - Upgraded for bee from drush
#
PATH=$HOME/.local/bin:$HOME/bin:$PATH
pattern="$1"
result=0

for _dir in "${HOME}"/apps/*"${pattern}"; do
	echo "${_dir}"
  cd "${_dir}" || exit
	FOLDER=$(basename "$PWD")
#	echo "${FOLDER}"
	./backupEssentials "${FOLDER}" 
  cd "${_dir}/web" || exit
	# ------------------------------------------------------------
  echo "Checking Upgrade Core is REALLY necessary"
  mkdir "/dev/shm/core_tmp"
  bee dl-core "/dev/shm/core_tmp"
  read -ra latest_array <<< $(cat "/dev/shm/core_tmp/core/profiles/standard/standard.info" | grep 'version = 1')
  echo "${latest_array[2]}"
  if [ "${latest_array[2]}" != "${version}" ]; then
    echo "Upgrading Core"
    mv core "core_${version}"
    mv /dev/shm/core_tmp/core .
  else
    echo "Core Upgrade Not Necessary"
  fi
  rm -fr /dev/shm/core_tmp
  echo ""
	echo "Upgrade Modules & Themes"
	bee update -y
	echo ""
	bee updb -y
  bee cc all
  cd "${_dir}" || exit
	./exportConfigSync
	git add -A
	git commit -am "Upgraded Backdrop Core & Modules as required"
done
echo "Now check that all is well with the site before deleting the core_${version} folder"
echo "THen merging and push to dev & prod"
exit ${result}

