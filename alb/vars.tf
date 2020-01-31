variable "name"                                 {                          } 
variable "internal"                             { default = false          } 
variable "subnet_ids"                           { type = "list"            } 
variable "enable_access_log"                    {                          } 
variable "target_group_vpc_id"                  {                          } 
variable "health_check_interval"                {                          } 
variable "health_check_path"                    {                          } 
variable "healthy_threshold"                    {                          } 
variable "unhealthy_threshold"                  {                          } 
variable "target_count"                         {                          } 
variable "target_ids"                           { type = "list"            } 
variable "target_port"                          {                          } 
variable "enable_https_listener"                {                          } 
variable "enable_http_listener"                 {                          } 
variable "alb_account_id"                       { default = "600734575887" } 
variable "log_transition_days"                  { default = 30             } 
variable "log_transition_storage_class"         { default = "GLACIER"      } 
variable "expiration"                           { default = 90             } 
variable "enable_http_egress"                   { default = true           } 
variable "http_source_egress_security_group_id" {                          } 
variable "ingress_cidr_blocks"                  { default = ["0.0.0.0/0"]  } 
variable "matcher"                              { default = "200"          } 
variable "ssl_policy"                           { default = ""             } 
variable "certificate_arn"                      { default = ""             } 
variable "http_ingress_port"                    { default = 80             } 
variable "https_ingress_source_sg"              { default = ""             } 
variable "http_ingress_source_sg"               { default = ""             } 
