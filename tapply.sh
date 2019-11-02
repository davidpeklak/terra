#!/usr/bin/env bash

terraform destroy -auto-approve
terraform apply -var="public_key=`cat terrakey.pub`" -auto-approve

echo "example \
  ansible_host=`terraform output public_ip` \
  ansible_user=ubuntu \
  ansible_private_key_file=../terrakey" > playbooks/hosts

# add ECDSA key of the machine to known_hosts, so that ansible does not prompt on first ssh
ssh-keyscan -H `terraform output public_ip` >> ~/.ssh/known_hosts
