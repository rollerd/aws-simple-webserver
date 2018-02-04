#!/bin/bash

# Generate key pair
ssh-keygen -b 2048 -t rsa -f `pwd`/id_rsa -N '' -C "AWS_EC2"

# Assign public key contents to variable
public_key=$(cat id_rsa.pub)

# Append export line to env var script
echo "export TF_VAR_ec2_public_key=\"$public_key\"" >> ../set_env.sh
