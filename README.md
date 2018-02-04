# Demo code for spinning up simple webserver and related infrastructure in AWS

This set of Ansible and Terraform configurations builds out the following resources in AWS 

* VPC 

* Public and private subnets

* Bastion host in the public subnet for accessing hosts on private subnet

* Webserver running NGINX in the private subnet

* NLB for allowing HTTP/HTTPS traffic to the webserver
#### Requirements
* [Terraform](https://www.terraform.io/) >= v0.11.1
* [Python3.x](https://www.python.org/)

#### Usage
First we need to create an SSH keypair that will be used in our EC2 instances:
* You can create this keypair manually or run the `create_keys.sh` script in the `keys/` directory of this project
  * **Note:** The script does not create a passphrase, so if you would like to create the keypair manually you will need to export the contents of the **public** key as an environment variable called: `TF_VARS_ec2_public_key` and add the key via ssh-agent

Next, we need to setup our secrets for use by Terraform, Ansible, and boto:

* Edit the `set_env.sh` file and enter your data for the AWS_SECRET_ACCESS_KEY and AWS_ACCESS_KEY_ID
  * **Note:** If you change the aws region, you will need to update the AMIs in the main.tf Terraform config file to AMIs for that region.
* Source the `set_env.sh` file: `. ./set_env.sh`

Now we just need to create a Python virtualenv and install the requirements for Ansible:
* You can use [mkvirtualenv](https://virtualenvwrapper.readthedocs.io/en/latest/) or build and activate the virtualenv manually
* pip install the requirements: `pip install -r requirements.txt`

###### Running Terraform
Run the following commands, checking that the ouput matches what you expect each time:
* `terraform init`
* `terraform plan`
* `terraform apply`

###### Running the Ansible plays to configure the webserver
Once Terraform has completed its build out, enter the `ansible/` directory and run: `ansible-playbook configure_webserver.yml`
Ansible will use the bastion as a jump host to configure the webserver, so the playbook run may be a little slower than what you normally see.




