#!/bin/bash
#
# Script to run 3 playbooks as Step 1 for Backdrop Upgrade
#
# Reset BASH time counter
SECONDS=0
cd "${HOME}/ansible"
echo "Running Playbook for Remote Prod"
ansible-playbook ~/ansible/backdrop_upgrade_made_easy/playbooks/backdrop_step_1_remote_prod.yaml
echo "Running Playbook for Remote Dev"
ansible-playbook ~/ansible/backdrop_upgrade_made_easy/playbooks/backdrop_step_1_remote_dev.yaml
echo "Running Playbook for Local"
ansible-playbook ~/ansible/backdrop_upgrade_made_easy/playbooks/backdrop_step_1_local.yaml
echo "Finished"
ELAPSED="Elapsed: $(($SECONDS / 3600))hrs $((($SECONDS / 60) % 60))min $(($SECONDS % 60))sec"
echo "${ELAPSED}"

