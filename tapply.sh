#!/usr/bin/env bash

terraform destroy -var="public_key=`cat terrakey.pub`" -auto-approve
terraform apply -var="public_key=`cat terrakey.pub`" -auto-approve

echo "coordinator \
  ansible_host=`terraform output coordinator_public_ip` \
  ansible_user=ubuntu \
  ansible_private_key_file=../terrakey" > playbooks/hosts

echo "worker_1 \
  ansible_host=`terraform output worker_1_public_ip` \
  ansible_user=ubuntu \
  ansible_private_key_file=../terrakey" > playbooks/hosts

# add ECDSA key of the machine to known_hosts, so that ansible does not prompt on first ssh
ssh-keyscan -H `terraform output worker_1_public_ip` >> ~/.ssh/known_hosts
