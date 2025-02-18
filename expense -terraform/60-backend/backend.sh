#!/bin/bash
dnf install ansible -y
ansible-pull -i localhost, -U https://github.com/SrikanthBommadi/Terraform/tree/main/ansible.terraform main.yaml -e COMPONENT=backend -e ENVIRONMENT=$1