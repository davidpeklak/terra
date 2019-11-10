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
tapply.sh
```

# Ansible

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
export ANSIBLE_HOST_KEY_CHECKING=False
ansible-playbook citus.yml --extra-vars "@vars.yml"
```
