#!/bin/bash
dnf install ansible -y
ansible-pull  -i localhost, -U https://github.com/SrikanthBommadi/ansibleroles.tf.git main.yaml -e COMPONENT=backend -e ENVIRONMENT=$1