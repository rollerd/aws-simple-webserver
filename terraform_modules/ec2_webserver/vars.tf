variable "vpc_id" {
  description = "VPC ID"
}

variable "webserver_sec_grp_name" {
  description = "Tag name for webserver sec group"
  default = "webserver_sec_grp"
}

variable "webserver_ami" {
  description = "Webserver AMI. Default=CentOS7"
  default = "ami-65e0e305"
}

variable "key_name" {
  description = "Key pair name"
}

variable "instance_type" {
  description = "Instance type. Default=t2.micro"
  default = "t2.micro"
}

variable "subnet_id" {
  description = "Subnet ID"
}

variable "tag_name" {
  description = "Tag Name"
  default = "webserver"
}

