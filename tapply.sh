#!/usr/bin/env bash

terraform apply -var="public_key=`cat terrakey.pub`" -auto-approve

echo "[all]" > playbooks/hosts

echo "coordinator \
  ansible_host=`terraform output coordinator_public_ip` \
  ansible_user=ubuntu \
  ansible_private_key_file=../terrakey" >> playbooks/hosts

echo "worker_1 \
  ansible_host=`terraform output worker_1_public_ip` \
  ansible_user=ubuntu \
  ansible_private_key_file=../terrakey" >> playbooks/hosts

echo "worker_2 \
  ansible_host=`terraform output worker_2_public_ip` \
  ansible_user=ubuntu \
  ansible_private_key_file=../terrakey" >> playbooks/hosts

echo "Writing to known_hosts..."

# add ECDSA key of the machine to known_hosts, so that ansible does not prompt on first ssh
ssh-keyscan -H `terraform output coordinator_public_ip` >> ~/.ssh/known_hosts 2> /dev/null
ssh-keyscan -H `terraform output worker_1_public_ip` >> ~/.ssh/known_hosts 2> /dev/null
ssh-keyscan -H `terraform output worker_2_public_ip` >> ~/.ssh/known_hosts 2> /dev/null

echo "Done"
