#!/bin/bash

mkdir -p /opt/github
cd /opt/github
yum install -y git
git clone git://github.com/ansible/ansible.git --recursive
#yum install -y python, already installed
yum install -y python-setuptools
easy_install pip
yum install -y ftp://mirror.switch.ch/pool/4/mirror/centos/7.3.1611/cloud/x86_64/openstack-kilo/common/pyparsing-2.0.3-1.el7.noarch.rpm
yum groupinstall -y 'Development Tools'
yum install -y python2.7-devel
yum install -y libffi-dev
#yum install -y openssl-devel, already installed
yum install -y sshpass
pip install paramiko
pip install PyYAML
pip install Jinja2
pip install httplib2
pip install six

