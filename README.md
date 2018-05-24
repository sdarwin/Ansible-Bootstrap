Ansible Bootstrap
=========

A role to bootstrap a node, so that ansible can manage it. Before ansible can manage a server it needs to be able to ssh in. This sets up an ansible user account on the client.

Many Galaxy roles include a lot of functionality in their bootstrap code, and while that is certainly very important, it might be referred to as the "standard server" role, rather than bootstrap. This is a tiny playbook just to get ssh working for the ansible user. 

If you already have a default administrative account on all the servers such as ec2-user, ubuntu, or centos then you may utilize that account as the ansible user without modification. Therefore, this role is not required. The original strategy here was to create a dedicated user account called "ansible", which was distinct from the "ubuntu" user, for example, and the "ansible" user would the one running playbooks on all client machines.

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

2. Create the 'ansible' user on the control machine.

```
adduser ansible
su - ansible
mkdir .ssh
cd .ssh
ssh-keygen
cp id_rsa.pub authorized_keys
cd ..
chmod -R 700 .ssh
exit
```
The main point of this is generating ansible's ssh keys. You could possibly just create a set of ssh keys without creating an entirely new user. But the method here allows you to treat the control machine as a "client" also.

-----

FURTHER STEPS, OPTION 1. FULL END-TO-END SSH FORWARDING. (recommended)

3. Copy the public and private keys which you had created with ssh-keygen to your local computer.

4. Modify scripts/sshagent.sh as necessary, and run scripts/sshagent.sh from your local computer. Then ssh into the control machine with ssh forwarding enabled, that is ssh -A

5. Every time you log in to the Ansible Control Machine as the user who will be running ansible (either root or ansible probably), run this script as follows. It will load ansible from sourcecode. Or add it to your .bashrc file.

```
source scripts/ansibleboot.sh
```

and proceed to Step 6 below.

-----

FURTHER STEPS, OPTION 2. SSH FORWARDING only from the control machine.

3. Copy the public and private keys which you had created with ssh-keygen to your local computer.

4. Using those ssh keys, from Step 3, ssh into the control machine.

5. Every time you log in to the Ansible Control Machine as the user who will be running ansible (either root or ansible probably), run this script as follows. It will load ansible from sourcecode, and load ssh keys. Or add it to your .bashrc file. (review and modify those scripts if necessary)

```
source scripts/sshagent.sh
source scripts/ansibleboot.sh
```

-----

6. configure your group_vars file at /etc/ansible/group_vars/all (or in a customized location), and include these variables:

```
bootstrap_ansibleuser: ansible
bootstrap_publickey: |
  ssh-rsa place-ssh-key-here-
```
Replace the ssh key with your public key. Keep the blank spaces before ssh-rsa.
The key should be ansible's public key, which was generated in Step 2. This is not to be confused with the server's initial admin keys (such as root, ec2-user, or ubuntu). 

7. For each New Host:

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

[![Analytics](https://ga-beacon.appspot.com/UA-112361697-1/Ansible-Bootstrap)](https://github.com/igrigorik/ga-beacon)

