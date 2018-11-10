# RDS Aurora

Terraform module to for RDS Aurora instance. This module creates the followings:
* Aurora RDS DB instance
* DB Subnet group
* DB Parameter group that has character settings set to UTF-8.

## Usage
```terraform
module "aurora" {
  source = "github.com/rampart81/terraform-modules//rds_aurora"

  engine                       = "aurora-mysql"
  name                         = "aurora"
  subnet_ids                   = "${var.subnet_ids}"
  db_parameter_group_family    = "aurora-mysql5.7"
  instance_class               = "db.t2.medium"
  master_username              = "${var.username}"
  master_password              = "${var.password}"
  apply_immediately            = true
  backup_retention_period      = 14
  storage_encrypted            = true
  cluster_identifier           = "prod-aurora-cluster"
  availability_zones           = ["${data.aws_availability_zones.available.names}"]
  database_name                = "${var.database_name}"
  preferred_backup_window      = "03:00-04:00"
  preferred_maintenance_window = "sat:04:00-sat:05:00"
  vpc_security_group_ids       = ["${aws_security_group.aurora.id}"]
  cluster_instance_count       = 2
}
```

## Variables
```terraform
variable "name"                         {                                } 
variable "subnet_ids"                   { type = "list"                  } 
variable "db_parameter_group_family"    {                                } 
variable "instance_class"               {                                } 
variable "master_username"              {                                } 
variable "master_password"              {                                } 
variable "apply_immediately"            {                                } 
variable "backup_retention_period"      {                                } 
variable "storage_encrypted"            {                                } 
variable "cluster_identifier"           {                                } 
variable "availability_zones"           { type = "list"                  } 
variable "database_name"                {                                } 
variable "preferred_backup_window"      {                                } 
variable "preferred_maintenance_window" {                                } 
variable "vpc_security_group_ids"       { type = "list"                  } 
variable "cluster_instance_count"       {                                } 
variable "engine"                       { default = "aurora-mysql"       } 
variable "max_allowed_packet"           { default = "209715200"          } 
```

For more information on the variables, refer to the [terraform site](https://www.terraform.io/docs/providers/aws/r/db_instance.html#argument-reference).

## Outputs
* cluster_id
* cluster_identifier
* cluster_resource_id
* cluster_members
* availability_zones
* backup_retention_period
* preferred_backup_window
* endpoint
* reader_endpoint
* engine
* engine_version
* hosted_zone_id
* database_name
* port
* storage_encrypted
* master_username
* instance_ids
* instance_identifiers
* dbi_resource_ids
