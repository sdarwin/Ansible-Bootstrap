#!/bin/bash

mkdir -p /opt/github
cd /opt/github
git clone git://github.com/ansible/ansible.git --recursive
apt-get update
apt-get install -y python
apt-get install -y python-setuptools
easy_install pip
apt-get install -y build-essential
apt-get install -y libpython2.7-dev
apt-get install -y libffi-dev
apt-get install -y libssl-dev
apt-get install -y sshpass
pip install paramiko
pip install PyYAML
pip install Jinja2
pip install httplib2
pip install six

