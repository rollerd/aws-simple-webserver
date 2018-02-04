variable "vpc_cidr_block" {
  description = "CIDR block for VPC. Default=10.100.0.0/16"
  default = "10.100.0.0/16"
}

variable "vpc_enable_dns_support" {
  description = "Enable/disable VPC DNS support. Default=true"
  default = 1
}

variable "vpc_enable_dns_hostnames" {
  description = "Enable/disable VPC DNS hostnames support. Default=true"
  default = 1
}

variable "vpc_tag_name" {
  description = "Set 'Name' tag value. Default=demo_vpc"
  default = "demo_vpc"
}

variable "aws_avail_zone" {
  description = "Availability zone to create VPC in"
}

variable "public_subnet_cidr" {
  description = "CIDR for VPC public subnet"
  default = "10.100.1.0/24"
}

variable "public_subnet_name" {
  description = "Set 'Name' tag value."
  default = "public"
}

variable "private_subnet_cidr" {
  description = "CIDR for VPC private subnet"
  default = "10.100.2.0/24"
}

variable "private_subnet_name" {
  description = "Set 'Name' tag value."
  default = "private"
}

variable "internet_gw_name" {
  default = "igw"
}

variable "public_route_table_name" {
  default = "pub_rt_table"
}

variable "private_route_table_name" {
  default = "priv_rt_table"
}

variable "nat_gw_tag" {
  default = "nat_gw"
}

