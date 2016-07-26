Install Ansible Controller Machine
=========

Even before using this playbook, here is a one-time procedure to install an ansible workstation on Ubuntu, if not already done.

```
mkdir -p /opt/github
cd /opt/github
git clone git://github.com/ansible/ansible.git --recursive
apt-get update
apt-get install python 
apt-get install python-setuptools
easy_install pip
apt-get install build-essential
apt-get install libpython2.7-dev
apt-get install libffi-dev
apt-get install libssl-dev
apt-get install sshpass
pip install paramiko
pip install PyYAML
pip install Jinja2
pip install httplib2
pip install six
```

And then every time you log-in, load ansible into the PATH:

```
source /opt/github/ansible/hacking/env-setup
eval "$(ssh-agent -s)"
ssh-add -l
#in the following step, replace the keyname with your private key, if different:
ssh-add /home/ansible/.ssh/id_rsa
ssh-add -l
```

