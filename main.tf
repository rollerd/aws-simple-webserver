variable "access_key" {} 
variable "secret_key" {}
variable "aws_region" {}
variable "ec2_public_key" {}
variable "aws_avail_zone" {}

# Configure our provider (AWS in this case)
provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.aws_region}"
  version    = "~> 1.1"
}

resource "aws_key_pair" "ec2_ssh_key" {
  key_name = "ec2_ssh_key"
  public_key = "${var.ec2_public_key}"
}

module "vpc" {
  source = "./terraform_modules/vpc"
  aws_avail_zone = "${var.aws_avail_zone}"
}

module "bastion_host" {
    source = "./terraform_modules/ec2_bastion"
    vpc_id = "${module.vpc.vpc_id}"
# Ubuntu 16.04 LTS AMI
    bastion_ami = "ami-07585467"
    key_name = "${aws_key_pair.ec2_ssh_key.key_name}"
    subnet_id = "${module.vpc.public_subnet}"
}

module "webserver" {
  source = "./terraform_modules/ec2_webserver"
  vpc_id = "${module.vpc.vpc_id}"
# CentOS 7 AMI
  webserver_ami = "ami-65e0e305"
  key_name = "${aws_key_pair.ec2_ssh_key.key_name}"
  subnet_id = "${module.vpc.private_subnet}"
}

module "elb" {
  source = "./terraform_modules/elb"
  vpc_id = "${module.vpc.vpc_id}"
  webserver_instance = "${module.webserver.instance_id}"
  webserver_sec_grp = "${module.webserver.web_sec_grp_id}"
  public_subnet = "${module.vpc.public_subnet}"
}

  
