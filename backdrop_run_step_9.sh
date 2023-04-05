#!/bin/bash
#
# Script to run Step 9 in Backdrop Upgrade
#
SECONDS=0
cd "${HOME}/ansible" || exit
logfile="${HOME}/ansible/Logs/backdrop_step_9.log"
ansible-playbook ~/ansible/backdrop_upgrade_made_easy/playbooks/backdrop_step_9.yaml -v 2>&1 | tee "${logfile}"
# Tidy up Line Feeds
sed -i 's/\\r\\n/\n/g' "${logfile}"
ELAPSED="Elapsed: (($SECONDS / 3600))hrs ((($SECONDS / 60) % 60))min (($SECONDS % 60))sec"
echo "${ELAPSED}"
echo "Finished"
echo "Then run the first step again to check for any Git upgrade Branches left over"
echo ""
echo "Log File is here ${logfile}"

