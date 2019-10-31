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

## Ssh
```bash
ssh ubuntu@`terraform output public_ip` -i terrakey
```

### Destroy
```bash
terraform destroy
```
