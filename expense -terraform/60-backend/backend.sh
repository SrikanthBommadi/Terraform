#!/bin/bash
dnf install ansible -y
ansible-pull -i localhost, -U  main.yaml -e COMPONENT=backend