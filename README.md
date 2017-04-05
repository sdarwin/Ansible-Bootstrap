Ansible Bootstrap
=========

A role to bootstrap a node, so that ansible can manage it. Before ansible can manage a server it needs to be able to ssh in. This sets up an ansible user account on the client.

Many Galaxy roles include a lot of functionality in their bootstrap code, and while that is certainly very important, it might be referred to as the "standard server" role, rather than bootstrap. This is a tiny playbook just to get ssh working for the ansible user. 

Instructions
----------------

Setup:

1. See docs/INSTALL.md for steps to install a new Ansible control machine, if not already done.

2. configure your group_vars file at /etc/ansible/group_vars/all (or in a customized location), and include these variables:
```
bootstrap_ansibleuser: ansible
bootstrap_publickey: |
  ssh-rsa place-ssh-key-here-
```

Replace the ssh key with your public key. Keep the blank spaces before ssh-rsa.

The key in the previous step is going to be ansible's key, and you should generate it with ssh-keygen. This is not to be confused with the initial admin key (such as root, ec2-user, or ubuntu). 

A recommended procedure would be to login on the control machine as root, and load your admin-level key "eval `ssh-agent`; ssh-add _key_ " so that it's available during the ssh sessions with the nodes.

For each New Host:

1. Add the new node into DNS or /etc/hosts

2. Add the new host to the ansible inventory such as /etc/ansible/hosts

3. Run this role, from it's directory location:
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

