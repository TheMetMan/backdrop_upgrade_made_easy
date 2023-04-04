#!/bin/bash
#
# Script to run Step 2 in Backdrop Upgrade
#
SECONDS=0
cd "${HOME}/ansible" || exit
logfile="Logs/backdrop_step_2.log"
ansible-playbook ~/ansible/backdrop_upgrade_made_easy/playbooks/backdrop_step_2.yaml -v 2>&1 | tee "${logfile}"
# Tidy up Line Feeds
sed -i 's/\\r\\n/\n/g' "${logfile}"
ELAPSED="Elapsed: (($SECONDS / 3600))hrs ((($SECONDS / 60) % 60))min (($SECONDS % 60))sec"
echo "${ELAPSED}"
echo "Log File is here ${logfile}"

