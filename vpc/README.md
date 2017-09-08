# vpc
Terraform module for VPC. 
This module creates the following AWS resources:
* VPC
* Two public subnets
* Two private subnets
* A routing table for the public subnets
* A routing table for the private subnets
* A internet gateway for the public subnets
* NAT gateway for the private subnets to access internet thru

## Usage
```terraform
module "backend" {
  source               = "github.com/rampart81/terraform-modules//vpc"
  name                 = "VPC"
  enable_dns_support   = true
  enable_dns_hostnames = true

  availability_zone1 = "ap-northeast-2a"
  availability_zone2 = "ap-northeast-2c"

  cidr_block                            = "10.0.0.0/16"
  public_availability_zone1_cidr_block  = "10.0.0.0/24"
  public_availability_zone2_cidr_block  = "10.0.1.0/24"
  private_availability_zone1_cidr_block = "10.0.20.0/24"
  private_availability_zone2_cidr_block = "10.0.21.0/24"
}
```

## Variables
```terraform
variable name                                  {                } 

variable cidr_block                            {                } 
variable public_availability_zone1_cidr_block  {                } 
variable public_availability_zone2_cidr_block  {                } 
variable private_availability_zone1_cidr_block {                } 
variable private_availability_zone2_cidr_block {                } 

variable availability_zone1                    { default = "ap-northeast-2a" } 
variable availability_zone2                    { default = "ap-northeast-2c" } 

variable enable_dns_support                    { default = true } 
variable enable_dns_hostnames                  { default = true } 
```

## Outputs
* `vpc_id`
* `vpc_cidr_block` 
* `public_availability_zone1_subnet_id` 
* `public_availability_zone2_subnet_id` 
* `public_subnet_ids` 
* `private_availability_zone1_subnet_id` 
* `private_availability_zone2_subnet_id` 
* `private_subnet_ids` 
* `public_route_table_id` 
* `private_route_table_id` 
