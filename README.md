Ansible Bootstrap
=========

A role to bootstrap a node, so that ansible can manage it. Before ansible can manage a server it needs to be able to ssh in. This sets up an ansible user account on the client.

Many Galaxy roles include a lot of functionality in their bootstrap code, and while that is certainly very important, it might be referred to as the "standard server" role, rather than bootstrap. This is a tiny playbook just to get ssh working for the ansible user. 

Instructions
----------------

Setup:

There is some flexibility to these steps, but here is a convenient methodology.

1. If you have not yet installed an Ansible control machine, do that now. The included scripts will install the necessary packages. If you have already installed ansible, it can be skipped. 

```
cd scripts/
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

2. Next, create the 'ansible' user locally, which will be used to connect to Ansible client machines in the future.

```
adduser ansible
su - ansible
mkdir .ssh
chmod 700 .ssh
cd .ssh
ssh-keygen
exit
```
The main point of this is generating ansible's ssh keys. You could possibly just create a set of ssh keys without creating an entirely new user. But the method here allows you to treat the control machine as a "client" also.

3. Every time you log in to the Ansible Control Machine as the user who will be running ansible (either root or ansible probably), run this script as follows. It will load your ssh key into ssh-agent, making it available for all ssh sessions with the nodes.

```
cd scripts
source ansibleboot.sh
```
Or, you may like to copy ansibleboot.sh to your home directory, and modify it as necessary. Reasons to modify it manually:
- if the ssh key will be different from the one listed there. Change it to point to your ssh key.
- if you have installed ansible from packages, and don't need the "source /opt/github/ansible/hacking/env-setup" line, just comment it out.

4. In the case of AWS, the way to initially connect to a new machine is with an ssh key. Only needed the first time. Add the key to the ssh agent:

```
#load ssh-agent. Already done if you ran ansibleboot.sh :
eval "$(ssh-agent -s)"

#add the key
ssh-add /root/.ssh/_my_key_
```

5. configure your group_vars file at /etc/ansible/group_vars/all (or in a customized location), and include these variables:

```
bootstrap_ansibleuser: ansible
bootstrap_publickey: |
  ssh-rsa place-ssh-key-here-
```
Replace the ssh key with your public key. Keep the blank spaces before ssh-rsa.
The key should be ansible's public key, which was generated in Step 2. This is not to be confused with the server's initial admin keys (such as root, ec2-user, or ubuntu). 

6. For each New Host:

- Add the new node into DNS or /etc/hosts

- Add the new host to the ansible inventory such as /etc/ansible/hosts

- Run this role, from it's directory location:
```
cd /etc/ansible/roles/sdarwin.bootstrap
ansible-playbook main.yml
```

It will prompt you for the host to be bootstrapped, and the user to connect as the first time. That will likely be "root", or "ubuntu", or whatever account has access. It then proceeds to configure the "ansible" user.

During the procedure, if it asks you about a password and you only have ssh keys, just ignore the question.

For a bit more development chat about the code in this role see docs/DISCUSSION.md.

License
-------

BSD

Author Information
------------------

By Sam Darwin, 2016.

Feedback and bug reports welcome.
