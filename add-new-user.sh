#!/bin/bash -e
ssh-keygen -f newuserkey -P ''
ansible-playbook add-user-to-group.yml