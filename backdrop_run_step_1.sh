#!/bin/bash
#
# Script to run 3 playbooks as Step 1 for Backdrop Upgrade
#
# Reset BASH time counter
SECONDS=0
cd "${HOME}/ansible" || exit
logfile="${HOME}/ansible/Logs/backdrop_step_1.log"
echo "Running Playbook for Remote Prod"
ansible-playbook ~/ansible/backdrop_upgrade_made_easy/playbooks/backdrop_step_1_remote_prod.yaml 2>&1 | tee "${logfile}"
echo "Running Playbook for Remote Dev"
ansible-playbook ~/ansible/backdrop_upgrade_made_easy/playbooks/backdrop_step_1_remote_dev.yaml 2>&1 | tee -a "${logfile}"
echo "Running Playbook for Local"
ansible-playbook ~/ansible/backdrop_upgrade_made_easy/playbooks/backdrop_step_1_local.yaml 2>&1 | tee -a "${logfile}"
# Tidy up Line Feeds
sed -i 's/\\r\\n/\n/g' "${logfile}"
ELAPSED="Elapsed: (($SECONDS / 3600))hrs ((($SECONDS / 60) % 60))min (($SECONDS % 60))sec"
echo "${ELAPSED}"
echo "Log File is here ${logfile}"

