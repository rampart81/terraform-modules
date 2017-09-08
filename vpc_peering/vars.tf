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
