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

echo "[coord]" >> playbooks/hosts
echo "coordinator" >> playbooks/hosts

echo "worker_1: `terraform output worker_1_private_ip`" > playbooks/vars.yml
echo "worker_2: `terraform output worker_2_private_ip`" >> playbooks/vars.yml

