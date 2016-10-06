
A review of some problems and their solutions in the code: 

- A new host will be missing from known_hosts, and so host_key_checking = False has been added to ansible.cfg. This requires you to run the role from the role's directory, to pick up that copy of ansible.cfg.  The new key is then added to known_hosts. An alternative solution is to manually ssh into the host first, so that the host key is installed.

- Fairly often a password will be needed, and so ask_pass=True has been added to ansible.cfg. An alternative solution is to specify this on the command-line --ask-pass.

- When connecting to a new node, the host and user values are needed. These have been added as var_prompts. You are prompted for them. An alternative soution would be to specify the variables on the command-line --extra-vars "hosts=ubuntu1404.example.com user=vagrant"

- In summary, if a few features of this role were to be rolled back, or commented out, you could run the role as follows:
```
ansible-playbook main.yml --ask-pass --extra-vars "hosts=ubuntu1404.example.com user=vagrant"
ansible-playbook main.yml --ask-pass --extra-vars "hosts=centos67 user=root"
```
filling in the hosts and user variables.

However, in the current implementation it can be run like this:
```
ansible-playbook main.yml
```


