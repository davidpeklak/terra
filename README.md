Initialize terraform
```bash
terraform init
```

Generate a key-pair, and set the public_key variable
```bash
rm terrakey*
ssh-keygen -f terrakey -N ""
TF_VAR_public_key=`cat terrakey.pub`
export TF_VAR_public_key
```

Apply
```bash
terraform apply
```