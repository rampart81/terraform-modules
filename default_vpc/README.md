## default_vpc
Terraform module for default VPC. This modules configures the default VPC (VPC that is automatically created when create a new AWS accont) and configures public subnets and creates private subnets. 
For the private subnets, it sets up NAT gateway so that private subnets can access internet thru the public subnets (but private subnets cannot be access externally)

## Usage
```terraform
module "default_vpc" {
  source               = "github.com/rampart81/terraform-modules//default_vpc"
  name                 = "Default VPC"
  enable_dns_support   = true
  enable_dns_hostnames = true

  availability_zone1 = "ap-northeast-2a"
  availability_zone2 = "ap-northeast-2c"

  private_availability_zone1_cidr_block = "172.31.32.0/20"
  private_availability_zone2_cidr_block = "172.31.64.0/20"
}
```

## Variables
```terraform
variable name                                  {                } 

# CIDR Block to set for the private subnets
variable private_availability_zone1_cidr_block {                } 
variable private_availability_zone2_cidr_block {                } 

# Avaibility zones for subnets
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
