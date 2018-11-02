# rds

Terraform module to for RDS Aurora instance. This module creates the followings:
* Aurora RDS DB instance
* DB Subnet group
* DB Parameter group that has character settings set to UTF-8.

## Usage
```terraform
module "mysql" {
  source = "github.com/rampart81/terraform-modules//rds"

  name                                = "mysql"
  username                            = "${var.username}"
  password                            = "${var.password}"
  subnet_ids                          = "${var.subnet_ids}"
  db_parameter_group_family           = "mysql5.7"
  allocated_storage                   = 20
  engine                              = "mysql"
  engine_version                      = "5.7.17"
  instance_class                      = "db.t2.micro"
  security_group_ids                  = ["${aws_security_group.mysql.id}"]
  multi_az                            = false
  storage_type                        = "gp2"
  publicly_accessible                 = false
  allow_major_version_upgrade         = true
  auto_minor_version_upgrade          = true
  apply_immediately                   = true
  maintenance_window                  = "Mon:00:00-Mon:03:00"
  skip_final_snapshot                 = false
  copy_tags_to_snapshot               = true
  backup_retention_period             = 1
  backup_window                       = "09:00-10:00"
  iam_database_authentication_enabled = true
  storage_encrypted                   = false
}
```

## Variables
```terraform
variable "name"                                {               } 
variable "subnet_ids"                          { type = "list" } 
variable "db_parameter_group_family"           {               } 
variable "allocated_storage"                   {               } 
variable "engine"                              {               } 
variable "engine_version"                      {               } 
variable "instance_class"                      {               } 
variable "username"                            {               } 
variable "password"                            {               } 
variable "security_group_ids"                  { type = "list" } 
variable "multi_az"                            {               } 
variable "storage_type"                        {               } 
variable "publicly_accessible"                 {               } 
variable "allow_major_version_upgrade"         {               } 
variable "auto_minor_version_upgrade"          {               } 
variable "apply_immediately"                   {               } 
variable "maintenance_window"                  {               } 
variable "skip_final_snapshot"                 {               } 
variable "copy_tags_to_snapshot"               {               } 
variable "backup_retention_period"             {               } 
variable "backup_window"                       {               } 
variable "iam_database_authentication_enabled" {               } 
variable "storage_encrypted"                   {               } 
```

For more information on the variables, refer to the [terraform site](https://www.terraform.io/docs/providers/aws/r/db_instance.html#argument-reference).

## Outputs
* address            
* arn                  
* allocated_storage     
* availability_zone     
* backup_retention_period
* backup_window         
* ca_cert_identifier    
* endpoint              
* engine                
* engine_version        
* hosted_zone_id        
* id                    
* instance_class        
* maintenance_window    
* multi_az              
* name                  
* port                  
* resource_id           
* status                
* storage_encrypted     
* username              
