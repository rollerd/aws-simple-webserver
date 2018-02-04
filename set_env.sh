export AWS_SECRET_ACCESS_KEY=
export AWS_ACCESS_KEY_ID=

# Note: with the current config, if you change regions here, you will need to change AMIs to match
export AWS_DEFAULT_REGION=us-west-1
export TF_VAR_access_key=$AWS_ACCESS_KEY_ID
export TF_VAR_secret_key=$AWS_SECRET_ACCESS_KEY
export TF_VAR_aws_region=$AWS_DEFAULT_REGION
export TF_VAR_aws_avail_zone=us-west-1a
