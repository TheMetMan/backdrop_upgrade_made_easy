#!/bin/bash
#
# Script to run Step 2 in Backdrop Upgrade
#
SECONDS=0
ansible-playbook ~/ansible/backdrop_upgrade_made_easy/lpaybooks/backdrop_step_2.yaml -v
ELAPSED="Elapsed: $(($SECONDS / 3600))hrs $((($SECONDS / 60) % 60))min $(($SECONDS % 60))sec"
echo "${ELAPSED}"

