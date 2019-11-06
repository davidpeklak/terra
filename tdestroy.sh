#!/usr/bin/env bash

terraform destroy -var="public_key=`cat terrakey.pub`" -auto-approve
