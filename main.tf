## Creating Wordpress Servers for app subnet A
resource "aws_security_group" "sg_wordpress" {

  name   = "sg_wordpress"
  vpc_id = aws_vpc.wordpress_vpc.id
  tags = {
    Name        = "sg-wordpress"
    Environment = "${var.environment}"
  }

}

resource "aws_security_group_rule" "allow_all" {
  type              = "ingress"
  cidr_blocks       = ["10.1.0.0/24"]
  to_port           = 0
  from_port         = 0
  protocol          = "-1"
  security_group_id = aws_security_group.sg_wordpress.id
}

resource "aws_security_group_rule" "outbound_allow_all" {
  type = "egress"

  cidr_blocks       = ["0.0.0.0/0"]
  to_port           = 0
  from_port         = 0
  protocol          = "-1"
  security_group_id = aws_security_group.sg_wordpress.id
}



resource "aws_instance" "wordpress_a" {
  ami                    = "ami-05654370f5b5eb0b0"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.app_subnet_a.id
  vpc_security_group_ids = ["${aws_security_group.sg_wordpress.id}"]
  key_name               = "TenableAB"

  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install -y httpd
              sudo service httpd start
              sudo echo "<html> <h1> Server A </h1> </html>" > /var/www/html/index.html
             EOF

  tags = {
    Name        = "adam-wordpress-a"
    Environment = "${var.environment}"
  }

}

##  END Creating Wordpress Servers for app subnet A


## Creating Wordpress Servers for app subnet B

resource "aws_instance" "wordpress_b" {
  ami                    = "ami-05654370f5b5eb0b0"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.app_subnet_b.id
  vpc_security_group_ids = ["${aws_security_group.sg_wordpress.id}"]
  key_name               = "TenableAB"

  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install -y httpd
              sudo service httpd start
              sudo echo "<html> <h1> Server B </h1> </html>" > /var/www/html/index.html
             EOF

  tags = {
    Name        = "adam-wordpress-b"
    Environment = "${var.environment}"
  }

}
## END Creating Wordpress Servers for app subnet B


