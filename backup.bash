#!/bin/bash

SSH_KEY_PATH=~/.ssh/apnc

eval "$(ssh-agent)"
ssh-add $SSH_KEY_PATH

ansible-playbook backup.yaml

mkdir -p $HOME/backups
scp ztm:/tmp/zulip-backup.tar.gz $HOME/backups
