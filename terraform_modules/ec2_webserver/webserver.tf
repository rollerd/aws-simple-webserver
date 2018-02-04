resource "aws_security_group" "webserver_sec_group" {
  name = "webserver_sec_grp"
  description = "Security group for webserver"
  vpc_id = "${var.vpc_id}"

  ingress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["10.100.2.0/24"]
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["10.100.1.0/24"]
  }

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["10.100.1.0/24"]
  }

  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["10.100.1.0/24"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "${var.webserver_sec_grp_name}"
    Project = "demo"
  }
}


resource "aws_instance" "webserver" {
  ami = "${var.webserver_ami}"
  associate_public_ip_address = 0
  key_name = "${var.key_name}"
  vpc_security_group_ids = ["${aws_security_group.webserver_sec_group.id}"]
  instance_type = "${var.instance_type}"
  subnet_id = "${var.subnet_id}"
  source_dest_check = false

  tags {
    Name = "${var.tag_name}"
    Project = "demo"
  }
}

# ----OUTPUTS ----
output "instance_id" {
  value = "${aws_instance.webserver.id}"
}

output "web_sec_grp_id" {
  value = "${aws_security_group.webserver_sec_group.id}"
}
