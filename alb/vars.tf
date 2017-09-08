variable "name"                                 { }
variable "internal"                             { default = false }
variable "subnet_ids"                           { type = "list" }
variable "enable_access_log"                    { }
variable "target_group_vpc_id"                  { }
variable "health_check_interval"                { }
variable "health_check_path"                    { }
variable "healthy_threshold"                    { }
variable "unhealthy_threshold"                  { }
variable "target_count"                         { }
variable "target_ids"                           { type = "list" }
variable "target_port"                          { }
variable "enable_https_listener"                { }
variable "enable_http_listener"                 { }
variable "alb_account_id"                       { }
variable "log_transition_days"                  { }
variable "log_transition_storage_class"         { }
variable "expiration"                           { }
variable "enable_http_egress"                   { }
variable "http_source_egress_security_group_id" { }
variable "ingress_cidr_blocks"                  { default = ["0.0.0.0/0"] }
variable "matcher"                              { }
variable "ssl_policy"                           { default = "" }
variable "certificate_arn"                      { default = "" }
variable "http_ingress_port"                    { default = 80 }
variable "https_ingress_source_sg"              { default = "" }
variable "http_ingress_source_sg"               { default = "" }
