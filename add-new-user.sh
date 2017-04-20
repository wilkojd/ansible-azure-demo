#!/bin/bash -e
ssh-keygen -f newuserkey -P ''
ansible-playbook manage-user-key.yml --extra-vars "user_state=present"