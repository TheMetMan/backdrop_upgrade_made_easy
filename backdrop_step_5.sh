#!/bin/bash
#
# script to Upgrade Backdrop and any modules on the Local Servers
#
PATH=$HOME/.local/bin:$HOME/bin:$PATH
pattern="$1"
result=0
for _dir in "${HOME}"/apps/*"${pattern}"; do
	echo "${_dir}"
        cd "${_dir}"
	FOLDER=$(basename "$PWD")
#	echo "${FOLDER}"
	./backupEssentials "${FOLDER}" 
        cd "${_dir}/web/modules"
	echo "Upgrade Core"
	yes | drush up core
	echo ""
	echo "Upgrade Modules"
	yes | drush up *
	echo ""
	drush updb -y
	drush cc all
        cd "${_dir}"
	./exportConfigSync
	git add -A
	git commit -am "Upgraded Backdrop Core & Modules as required"
done
echo "Now check that all is well with the site before merging and pushing to dev & prod"
exit ${result}

