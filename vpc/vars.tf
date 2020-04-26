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
}

variable "tags" {
  type     = "map"
  default  = {
    "Name" = var.name
  }
}

