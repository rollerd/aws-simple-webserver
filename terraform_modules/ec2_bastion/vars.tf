variable "vpc_id" {
  description = "VPC ID"
}

variable "bastion_sec_grp_name" {
  default = "bastion_sec_grp"
}

variable "bastion_ami" {
  description = "AMI for bastion host. Default=Ubuntu 16.04"
  default = "ami-07585467"
}

variable "key_name" {
  description = "key pair name"
}

variable "subnet_id" {
  description = "public subnet id"
}
