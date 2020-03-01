############################################################
# VPC 
############################################################
resource "aws_vpc" "vpc" {
  cidr_block           = var.cidr_block
  enable_dns_support   = var.enable_dns_support 
  enable_dns_hostnames = var.enable_dns_hostnames 

  tags { Name = var.name }
}

############################################################
# Public Subnets
############################################################
resource "aws_subnet" "public_availability_zones" {
  count             = length(var.public_availabile_zones)
	vpc_id            = aws_vpc.vpc.id
	cidr_block        = var.public_availabile_zones[count.indedx].cidr_block
	availability_zone = var.public_availabile_zones[count.indedx].zone

  tags { Name = "${var.name} Public Availability Zone ${count.index}" }
}

############################################################ 
# Private Subnets
############################################################
resource "aws_subnet" "private_availability_zones" {
  count             = length(var.private_availabile_zones)
	vpc_id            = aws_vpc.vpc.id
	cidr_block        = var.private_availabile_zones[count.indedx].cidr_block
	availability_zone = var.private_availabile_zones[count.indedx].zone

  tags { Name = "${var.name} Private Availability Zone ${count.index}" }
}


############################################################
# EIP
############################################################
resource "aws_eip" "nat" {
  vpc = true
}

############################################################
# Routing table for public subnets
############################################################
resource "aws_internet_gateway" "ig" {
  vpc_id = aws_vpc.vpc.id

  tags { Name = "${var.name} Internet Gateway" }
}

resource "aws_default_route_table" "default" {
  default_route_table_id = aws_vpc.vpc.default_route_table_id


  tags { Name = "${var.name} Public Default Route Table" }
}

resource "aws_route" "public" {
	route_table_id         = aws_vpc.vpc.default_route_table_id
	destination_cidr_block = "0.0.0.0/0"
	gateway_id             = aws_internet_gateway.ig.id
}

resource "aws_route_table_association" "public" {
  count          = length(var.public_availabile_zones)
	subnet_id      = aws_subnet.public_availability_zones[count.index].id
	route_table_id = aws_vpc.vpc.default_route_table_id
}

############################################################
# Routing table for private subnets
############################################################
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public_availability_zones[0].id
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.vpc.id

  tags { Name = "${var.name} Private Route Table" }
}

resource "aws_route" "private" {
	route_table_id         = aws_route_table.private.id
	destination_cidr_block = "0.0.0.0/0"
	nat_gateway_id         = aws_nat_gateway.nat.id
}

resource "aws_route_table_association" "private1" {
	subnet_id      = aws_subnet.private_availability_zone1.id
	route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private2" {
	subnet_id      = aws_subnet.private_availability_zone2.id
	route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private" {
  count          = length(var.private_availabile_zones)
	subnet_id      = aws_subnet.private_availability_zones[count.index].id
	route_table_id = aws_vpc.vpc.default_route_table_id
}
