Ansible Bootstrap
=========

A role to bootstrap a node, so that ansible can manage it.  Before ansible can manage a server it needs to be able to ssh in.  This sets up an ansible user account on the client. 

Many Galaxy roles include a lot of functionality in their bootstrap code, and while that is certainly very important, it might be referred to as the "standard server" role, rather than bootstrap. This is a tiny playbook just to get ssh working for the ansible user.  

Pre-Requirements
------------

see docs/INSTALL.md for steps to install a new Ansible control machine, if not already done.

Instructions
----------------

1. Set the public ssh key for ansible as the sshpublickey variable in defaults/main.yml.  Which means you will need to fork the playbook and modify it with your custom key.  Or follow the wrapper pattern, where this role is a dependency, and the key is set by the calling role.

2. Edit /etc/hosts and add an entry for the new server.  Or update DNS with the new server.

3. Add the new host to the ansible inventory such as /etc/ansible/hosts

4. When running this playbook, you will need to know the initial root user, or sudo account, on the new server.   That will be specified on the command-line as user= .   This is one-time only, because after the role has been run, it will have the new ansible user and ssh key.

A main.yml playbook is included with this role.  Run it as follows.

Examples:  
ansible-playbook main.yml --ask-pass --extra-vars "hosts=ubuntu1404.example.com user=vagrant"  
ansible-playbook main.yml --ask-pass --extra-vars "hosts=centos67 user=root"  

filling in the hosts and user variables.

License
-------

BSD

Author Information
------------------

By Sam Darwin, 2016.

Feedback and bug reports welcome.

