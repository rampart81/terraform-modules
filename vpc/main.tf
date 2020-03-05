############################################################
# VPC 
############################################################
resource "aws_vpc" "vpc" {
  cidr_block           = var.cidr_block
  enable_dns_support   = var.enable_dns_support 
  enable_dns_hostnames = var.enable_dns_hostnames 

  tags = { Name = var.name }
}

############################################################
# Public Subnets
############################################################
resource "aws_subnet" "public_availability_zones" {
  for_each = { for v in var.public_available_zones : v.zone => v }

	vpc_id            = aws_vpc.vpc.id
	cidr_block        = each.value.cidr_block
	availability_zone = each.value.zone

  tags = { Name = "${var.name} Public Availability Zone ${each.key}" }
}

############################################################ 
# Private Subnets
############################################################
resource "aws_subnet" "private_availability_zones" {
  for_each = { for v in var.private_available_zones : v.zone => v }

	vpc_id            = aws_vpc.vpc.id
	cidr_block        = each.value.cidr_block
	availability_zone = each.value.zone

  tags = { Name = "${var.name} Private Availability Zone ${each.key}" }
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

  tags = { Name = "${var.name} Internet Gateway" }
}

resource "aws_default_route_table" "default" {
  default_route_table_id = aws_vpc.vpc.default_route_table_id


  tags = { Name = "${var.name} Public Default Route Table" }
}

resource "aws_route" "public" {
	route_table_id         = aws_vpc.vpc.default_route_table_id
	destination_cidr_block = "0.0.0.0/0"
	gateway_id             = aws_internet_gateway.ig.id
}

resource "aws_route_table_association" "public" {
  for_each = aws_subnet.public_availability_zones

	subnet_id      = each.value.id
	route_table_id = aws_vpc.vpc.default_route_table_id
}

############################################################
# Routing table for private subnets
############################################################
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public_availability_zones["ap-northeast-2a"].id
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.vpc.id

  tags = { Name = "${var.name} Private Route Table" }
}

resource "aws_route" "private" {
	route_table_id         = aws_route_table.private.id
	destination_cidr_block = "0.0.0.0/0"
	nat_gateway_id         = aws_nat_gateway.nat.id
}

resource "aws_route_table_association" "private" {
  for_each = aws_subnet.private_availability_zones

	subnet_id      = each.value.id
	route_table_id = aws_vpc.vpc.default_route_table_id
}
