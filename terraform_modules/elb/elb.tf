resource "aws_security_group" "elb_sec_grp" {
  name = "elb_sec_grp"
  vpc_id = "${var.vpc_id}"

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    security_groups = ["${var.webserver_sec_grp}"]
  }

  egress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    security_groups = ["${var.webserver_sec_grp}"]
  }

  tags {
    Name = "elb_sec_grp"
    Project = "demo"
  }
}

resource "aws_elb" "webserver_elb" {
  name = "webserver-elb"
  subnets = ["${var.public_subnet}"]
  security_groups = ["${aws_security_group.elb_sec_grp.id}"]

  listener {
    instance_port = 80
    instance_protocol = "http"
    lb_port = 80
    lb_protocol = "http"
  }

  listener {
    instance_port = 443
    instance_protocol = "tcp"
    lb_port = 443
    lb_protocol = "tcp"
  }

  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 3
    target = "HTTPS:443/index.html"
    interval = 30
  }

  tags {
    Name = "webserver_elb"
    Project = "demo"
  }
}

resource "aws_elb_attachment" "webserver_elb_instance" {
  elb = "${aws_elb.webserver_elb.id}"
  instance = "${var.webserver_instance}"
}
