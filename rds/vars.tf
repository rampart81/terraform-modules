variable "name"                                {             } 
variable "subnet_ids"                          { type = list } 
variable "db_parameter_group_family"           {             } 
variable "allocated_storage"                   {             } 
variable "engine"                              {             } 
variable "engine_version"                      {             } 
variable "instance_class"                      {             } 
variable "username"                            {             } 
variable "password"                            {             } 
variable "security_group_ids"                  { type = list } 
variable "multi_az"                            {             } 
variable "storage_type"                        {             } 
variable "iops"                                { default = "" } 
variable "publicly_accessible"                 {             } 
variable "allow_major_version_upgrade"         {             } 
variable "auto_minor_version_upgrade"          {             } 
variable "apply_immediately"                   {             } 
variable "maintenance_window"                  {             } 
variable "skip_final_snapshot"                 {             } 
variable "copy_tags_to_snapshot"               {             } 
variable "backup_retention_period"             {             } 
variable "backup_window"                       {             } 
variable "iam_database_authentication_enabled" {             } 
variable "storage_encrypted"                   {             } 
