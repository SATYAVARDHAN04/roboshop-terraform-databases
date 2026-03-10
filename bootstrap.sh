#! /bin/bash
dnf install ansible -y
ansible-pull -U https://github.com/SATYAVARDHAN04/ansible-roles-roboshop.git -e component=$1 main.yaml