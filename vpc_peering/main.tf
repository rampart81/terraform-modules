############################################################
# VPC Peering
#
# Steps:
# 1. Create a vpc peering connection
# 2. Create routes from primary vpc subnets (both public and private) to the secondary vpc
# 3. Create routes from secondary vpc subnets (both public and private) to the primary vpc
#
############################################################
resource "aws_vpc_peering_connection" "vpc_peering" {
  # Main VPC ID.
  vpc_id = "${var.primary_vpc_id}"

  # AWS Account ID. This can be dynamically queried using the
  # aws_caller_identity data resource.
  # https://www.terraform.io/docs/providers/aws/d/caller_identity.html
  peer_owner_id = "${var.peer_owner_id}"

  # Secondary VPC ID.
  peer_vpc_id = "${var.secondary_vpc_id}"

  # Flags that the peering connection should be automatically confirmed. This
  # only works if both VPCs are owned by the same account.
  auto_accept = true

  tags {
    Name = "${var.name}"
  }
}

############################################################
# Route from the primary vpc to the secondary vpc
############################################################
resource "aws_route" "primary_vpc_public_to_secondary_vpc" {
  # ID of VPC 1 main route table.
  route_table_id = "${var.primary_public_route_table_id}"

  # CIDR block / IP range for VPC 2.
  destination_cidr_block = "${var.secondary_vpc_cidr_block}"

  # ID of VPC peering connection.
  vpc_peering_connection_id = "${aws_vpc_peering_connection.vpc_peering.id}"
}

resource "aws_route" "primary_vpc_private_to_secondary_vpc" {
  # ID of VPC 1 main route table.
  route_table_id = "${var.primary_private_route_table_id}"

  # CIDR block / IP range for VPC 2.
  destination_cidr_block = "${var.secondary_vpc_cidr_block}"

  # ID of VPC peering connection.
  vpc_peering_connection_id = "${aws_vpc_peering_connection.vpc_peering.id}"
}

############################################################
# Route from the secondary vpc to the primary vpc
############################################################
resource "aws_route" "secondary_vpc_public_to_primary_vpc" {
  # ID of VPC 2 main route table.
  route_table_id = "${var.secondary_public_route_table_id}"

  # CIDR block / IP range for VPC 2.
  destination_cidr_block = "${var.primary_vpc_cidr_block}"

  # ID of VPC peering connection.
  vpc_peering_connection_id = "${aws_vpc_peering_connection.vpc_peering.id}"
}

resource "aws_route" "secondary_vpc_private_to_primary_vpc" {
  # ID of VPC 2 main route table.
  route_table_id = "${var.secondary_private_route_table_id}"

  # CIDR block / IP range for VPC 2.
  destination_cidr_block = "${var.primary_vpc_cidr_block}"

  # ID of VPC peering connection.
  vpc_peering_connection_id = "${aws_vpc_peering_connection.vpc_peering.id}"
}
