variable "vpc_id" {
  description = "VPC ID"
}

variable "webserver_sec_grp" {
  description = "webserver security group id"
}

variable "public_subnet" {
  description = "subnet to attach to ELB"
}

variable "webserver_instance" {
  description = "webserver instance to place in ELB pool"
}

