# Backdrop Upgrade Made Easy

## Prerequisites

You will need to have Git, Ansible and MY Fork of Bee (https://github.com/TheMetMan/bee) installed. You must use my version because the official version (https://github.com/backdrop-contrib/bee) does not have a working `bee update` method yet. 
Ansible Documentation is [here](https://docs.ansible.com/ansible/latest/index.html)

With Ansible, you will need to have your own Ansible Hosts File setup for the Local, Dev and Prod Servers and correct the scripts accordingly. They do not need Sudo, just run as a normal user, but you will need ssh keys setup on the remote and local servers for password less login.

## To upgrade I follow this workflow:

- Sync Prod to Local and test
- Upgrade Local and test
- Sync Dev to Local and test
- Sync Prod to Local and test

It is useful to have a standard naming convention, so I use <SiteName>.local, <SiteName>dev and <SiteName>prod

My Local Sites are on a local server and the Dev and Prod on remote servers.

*IMPORTANT!*
I have created Bash Scripts to export and import the site configuration and database. Also, to upgrade core and modules. These can be found on GitHub [here](https://github.com/TheMetMan/backdrop-web-install) as well. See that project for more information.

## Automation and Streamlining:

I have a GitHub repository with my Scripts and Playbooks here

Follow each step of the workflow laid out below to upgrade all the sites.
In more detail:

1. Check that there are NO Git Branches called Update or Upgrade on Local and Remote Servers.  
    ~/ansible/backdrop\_upgrade\_made\_easy/backdrop\_run\_step_1.sh
2. ExportConfigSync on Prod Site and Git Push to Repo.  
~/ansible/backdrop_upgrade_made_easy/backdrop_run_step_2.sh
3. Create Git upgrade Branch on Local and Git Pull from Remote. Then ImportConfigSync.  
    ~/ansible/backdrop_upgrade_made_easy/backdrop_run_step_3.sh
4. Test Local Sites are OK, then clean up.  
   ~/ansible/backdrop_upgrade_made_easy/backdrop_run_step_4.sh
5. Upgrade Core and any modules then ExportConfigSync and Git Commit Upgrade.  
    ~/ansible/backdrop_upgrade_made_easy/backdrop_run_step_5.sh
6. Test Local Sites are OK.
7. Git checkout Master and Merge Upgrade and Delete Upgrade and Git Push to remote.  
    ~/ansible/backdrop_upgrade_made_easy/backdrop_run_step_7.sh
8. Create Git upgrade Branch on the DEV Server and pull from remote and importConfigSync. (Same as Step 3 but different hosts).  
    a. ~/ansible/backdrop_upgrade_made_easy/backdrop_run_step_8_01.sh  
    b. Test DEV Site is OK.  
    c. Create Git upgrade Branch on the PROD Server and pull from remote and importConfigSync. (Same as Step 8 but different hosts).  
    d. ~/ansible/backdrop_upgrade_made_easy/backdrop_run_step_8_02.sh  
    e. Test PROD Site is OK.  
9. If all OK, then run this to Git checkout Master and Merge Upgrade and Delete Upgrade on DEV and PROD.  
     ~/ansible/backdrop_upgrade_made_easy/backdrop_run_step_9.sh
10. Then run the first one to check for any Git upgrade Branches  
     ~/ansible/backdrop_upgrade_made_easy/backdrop_run_step_1.sh

## Important:

After each step above, the output can be copied and pasted from the Terminal into a simple text editor, and all the '\r\n' characters replaced by '\n' to see the correct formatting, then looked through quickly to see if there were any errors.

