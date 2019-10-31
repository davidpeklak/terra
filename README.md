# Terraform

### Initialize terraform
```bash
terraform init
```

### Generate a key-pair
```bash
rm terrakey*
ssh-keygen -f terrakey -N ""
```

### Apply
```bash
terraform apply -var="public_key=`cat terrakey.pub`"
```

### Ssh
```bash
ssh ubuntu@`terraform output public_ip` -i terrakey
```

# Ansible

### Create Ansible hosts file
```bash
echo "example \
  ansible_host=`terraform output public_ip` \
  ansible_user=ubuntu \
  ansible_private_key_file=../terrakey" > playbooks/hosts
```

All Ansible commands that follow are to be run in the playbooks directory
```bash
cd playbooks
```

### Ping machine through Ansible
```bash
ansible example -i hosts -m ping
```

### Download deb.sh
Download deb.sh as described [here](https://docs.citusdata.com/en/v8.3/installation/single_machine_debian.html)
```bash
curl https://install.citusdata.com/community/deb.sh > deb.sh
```

### Run playbook
```bash
ansible-playbook citus.yml 
```
