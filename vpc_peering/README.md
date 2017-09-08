# vpc_peering
Terraform module for VPC peering. VPC Peering allows communication between VPCs. More information can be found [here](http://docs.aws.amazon.com/AmazonVPC/latest/UserGuide/vpc-peering.html)

This module esatablish peering connections between the given two VPCs - connects both public and private subnets between the VPCs.

## Usage
```terraform
module "primary_to_secondary" {
  source = "github.com/rampart81/terraform-modules//vpc_peering"

  name = "primary_to_secondary"

  primary_vpc_id   = "${aws_vpc.primary.id}"
  peer_owner_id    = "${data.aws_caller_identity.current.account_id}"
  secondary_vpc_id = "${aws_vpc.secondary.id}"

  primary_vpc_cidr_block         = "${aws_vpc.primary.cidr_block}"
  primary_public_route_table_id  = "${aws_route_table.primary_public.id}"
  primary_private_route_table_id = "${aws_route_table.primary_private.id}"

  secondary_vpc_cidr_block         = "${aws_vpc.secondary.cidr_block}"
  secondary_public_route_table_id  = "${aws_route_table.secondary_public.id}"
  secondary_private_route_table_id = "${aws_route_table.secondary_private.id}"
}
```

## Variables
```terraform
variable "name"                            { }

variable "primary_vpc_id"                  { }
variable "peer_owner_id"                   { }
variable "secondary_vpc_id"                { }

variable "primary_vpc_cidr_block"          { }
variable "primary_public_route_table_id"   { }
variable "primary_private_route_table_id"  { }

variable "secondary_vpc_cidr_block"        { }
variable "secondary_public_route_table_id"  { }
variable "secondary_private_route_table_id" { }
```

## Outputs
* `vpc_peering_id`
* `vpc_peering_accept_status`
