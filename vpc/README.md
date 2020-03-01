# vpc
Terraform module for VPC. 
This module creates the following AWS resources:

* VPC
* Public subnets
* Private subnets
* A routing table for the public subnets
* A routing table for the private subnets
* A internet gateway for the public subnets
* NAT gateway for the private subnets to access internet thru

## Usage
```terraform
module "backend" {
  source               = "github.com/rampart81/terraform-modules//vpc"
  name                 = "Backend"
  enable_dns_support   = true
  enable_dns_hostnames = true
  cidr_block           = "10.0.0.0/16"

  public_available_zones = [
    {
      zone       = "ap-northeast-2a",
      cidr_block = "10.0.0.0/24"
    },
    {
      zone       = "ap-northeast-2b",
      cidr_block = "10.0.2.0/24"
    },
    {
      zone       = "ap-northeast-2c",
      cidr_block = "10.0.4.0/24"
    }
  ]

  private_available_zones = [
    {
      zone       = "ap-northeast-2a",
      cidr_block = "10.0.20.0/24"
    },
    {
      zone       = "ap-northeast-2b",
      cidr_block = "10.0.22.0/24"
    },
    {
      zone       = "ap-northeast-2c",
      cidr_block = "10.0.24.0/24"
    }
  ]
}
```

## Variables
```terraform
variable name                                  {                } 
variable cidr_block                            {                } 
variable enable_dns_support                    { default = true } 
variable enable_dns_hostnames                  { default = true } 

variable "public_available_zones" {
  type = list(object({
    cidr_block = string
    zone       = string
  }))
}

variable "private_available_zones" {
  type = list(object({
    cidr_block = string
    zone       = string
  }))
```

## Outputs
* `vpc_id`
* `vpc_cidr_block` 
* `public_subnet_ids` 
* `private_subnet_ids` 
* `public_route_table_id` 
* `private_route_table_id` 
* `nat_gateway_public_ip`
* `public_zone_to_subnet_id_map`
* `private_zone_to_subnet_id_map`
