Install Ansible Controller Machine
=========

Even before using this playbook, here is a one-time procedure to install an ansible workstation on Ubuntu, if not already done.

```
UBUNTU
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

REDHAT
mkdir -p /opt/github
cd /opt/github
yum install -y git
git clone git://github.com/ansible/ansible.git --recursive
#yum install -y python, already installed
yum install -y python-setuptools
easy_install pip
yum install ftp://mirror.switch.ch/pool/4/mirror/centos/7.3.1611/cloud/x86_64/openstack-kilo/common/pyparsing-2.0.3-1.el7.noarch.rpm
yum groupinstall 'Development Tools'
yum install -y python2.7-devel
yum install -y libffi-dev
#yum install -y openssl-devel, already installed
yum install -y sshpass
pip install paramiko
pip install PyYAML
pip install Jinja2
pip install httplib2
pip install six
```

Create a file ansibleboot.sh on the control machine:
```
#/bin/bash
source /opt/github/ansible/hacking/env-setup
eval "$(ssh-agent -s)"
ssh-add -l
#in the following step, replace the keyname with your private key, if different:
ssh-add /home/ansible/.ssh/id_rsa
ssh-add -l
```
Then once before using ansible:
source ansibleboot.sh

This implies that on the control machine you created a user called ansible, created ssh keys for ansible, and then subsequently run ansible as either ansible or root.

