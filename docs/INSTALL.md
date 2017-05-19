Install Ansible Controller Machine
=========

Even before using this playbook, here is a one-time procedure to install an ansible workstation, if not already done.

The code is in the scripts/ folder of this role. Read the contents of the scripts, as they are just a series of simple bash commands to install packages.

First, change to the directory:
```
cd ../scripts/
```

UBUNTU
```
chmod 755 install-ansible-ubuntu.sh
./install-ansible-ubuntu.sh
```
REDHAT
```
chmod 755 install-ansible-redhat.sh
./install-ansible-redhat.sh
```
----

Next, create the 'ansible' user locally, which will be used to connect to Ansible client machines in the future.
```
adduser ansible
su - ansible
mkdir .ssh
chmod 700 .ssh
cd .ssh
ssh-keygen
exit
```
Next, every time you log in to the Ansible Control Machine as the user who will be running ansible (either root or ansible probably), run this script as follows:
```
source ansibleboot.sh
```
You may like to copy ansibleboot.sh to your home directory, and modify it as necessary if the ssh key will be different from the one listed.

