# Create internet gateway for our VPC
resource "aws_internet_gateway" "wordpress_igateway" {
  vpc_id = aws_vpc.wordpress_vpc.id

  tags = {
    Name        = "wordpress-igateway"
    Environment = "${var.environment}"
  }

  depends_on = aws_vpc.wordpress_vpc
}


# Create a route table so we can assign public-a and public-b subnet to this route table
resource "aws_route_table" "rtb_public" {

  vpc_id = aws_vpc.wordpress_vpc.id
  tags = {
    Name        = "wordpress-public-routetable"
    Environment = "${var.environment}"
  }

  depends_on = ["aws_vpc.wordpress_vpc"]
}


# Create a route in the route table, to access public via internet gateway
resource "aws_route" "route_igw" {
  route_table_id         = aws_route_table.rtb_public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.wordpress_igateway.id

  depends_on = ["aws_internet_gateway.wordpress_igateway"]
}


# Add  public-a subnet to the route table
resource "aws_route_table_association" "rta_subnet_association_puba" {
  subnet_id      = aws_subnet.public_subnet_a.id
  route_table_id = aws_route_table.rtb_public.id

  depends_on = ["aws_route_table.rtb_public"]
}

# Add  public-b subnet to the route table
resource "aws_route_table_association" "rta_subnet_association_pubb" {
  subnet_id      = aws_subnet.public_subnet_b.id
  route_table_id = aws_route_table.rtb_public.id

  depends_on = ["aws_route_table.rtb_public"]
}
