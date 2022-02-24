## Create a nat gateway for public a subnet
resource "aws_eip" "eip_public_a" {
  vpc = true
}
resource "aws_nat_gateway" "gw_public_a" {
  allocation_id = "${aws_eip.eip_public_a.id}"
  subnet_id     = "${aws_subnet.public_subnet_a.id}"

  tags = {
    Name = "wordpress-nat-public-a"
  }
}
## End Create a nat gateway in public a subnet


## Create Routing Table for app a subnet
resource "aws_route_table" "rtb_appa" {

  vpc_id = "${aws_vpc.wordpress_vpc.id}"
  tags = {
    Name        = "wordpress-appa-routetable"
    Environment = "${var.environment}"
  }

}

#create a route to nat gateway 
resource "aws_route" "route_appa_nat" {
  route_table_id         = "${aws_route_table.rtb_appa.id}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = "${aws_nat_gateway.gw_public_a.id}"
}


resource "aws_route_table_association" "rta_subnet_association_appa" {
  subnet_id      = "${aws_subnet.app_subnet_a.id}"
  route_table_id = "${aws_route_table.rtb_appa.id}"
}

##  End Create Routing Table for app a subnet


## Create Nat gatway and routes for app subnet B 
resource "aws_eip" "eip_public_b" {
  vpc = true
}
resource "aws_nat_gateway" "gw_public_b" {
  allocation_id = "${aws_eip.eip_public_b.id}"
  subnet_id     = "${aws_subnet.public_subnet_b.id}"

  tags = {
    Name = "wordpress-nat-public-b"
  }
}

resource "aws_route_table" "rtb_appb" {

  vpc_id = "${aws_vpc.wordpress_vpc.id}"
  tags = {
    Name        = "wordpress-appb-routetable"
    Environment = "${var.environment}"
  }

}

resource "aws_route" "route_appb_nat" {
  route_table_id         = "${aws_route_table.rtb_appb.id}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = "${aws_nat_gateway.gw_public_b.id}"
}


resource "aws_route_table_association" "rta_subnet_association_appb" {
  subnet_id      = "${aws_subnet.app_subnet_b.id}"
  route_table_id = "${aws_route_table.rtb_appb.id}"
}
## END Create Nat gatway and routes for app subnet B 
