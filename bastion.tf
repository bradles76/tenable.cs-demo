## Create Bastion Server

resource "aws_security_group" "sg_22" {

  name   = "sg_22"
  vpc_id = "${aws_vpc.wordpress_vpc.id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "sg-22"
    Environment = "${var.environment}"
  }

}


# Create NACL for access bastion host via port 22
resource "aws_network_acl" "wordpress_public_a" {
  vpc_id = "${aws_vpc.wordpress_vpc.id}"

  subnet_ids = ["${aws_subnet.public_subnet_a.id}"]

  tags = {
    Name        = "acl-wordpress-public-a"
    Environment = "${var.environment}"
  }
}

resource "aws_network_acl_rule" "inbound_rule_22" {
  network_acl_id = "${aws_network_acl.wordpress_public_a.id}"
  rule_number    = 200
  egress         = false
  protocol       = "-1"
  rule_action    = "allow"
  # Opening to 0.0.0.0/0 can lead to security vulnerabilities.
  cidr_block = "0.0.0.0/0"
  from_port  = 0
  to_port    = 0
}

resource "aws_network_acl_rule" "outbound_rule_22" {
  network_acl_id = "${aws_network_acl.wordpress_public_a.id}"
  rule_number    = 200
  egress         = true
  protocol       = "-1"
  rule_action    = "allow"
  # Opening to 0.0.0.0/0 can lead to security vulnerabilities.
  cidr_block = "0.0.0.0/0"
  from_port  = 0
  to_port    = 0
}
# Create NACL for access bastion host via port 22

resource "aws_instance" "wordpress_bastion" {
  ami                    = "ami-05654370f5b5eb0b0"
  instance_type          = "t2.micro"
  subnet_id              = "${aws_subnet.public_subnet_a.id}"
  vpc_security_group_ids = ["${aws_security_group.sg_22.id}"]
  key_name               = "TenableAB"

  tags = {
    Name        = "wordpress-bastion"
    Environment = "${var.environment}"
  }

}
