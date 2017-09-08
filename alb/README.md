# ALB
A Terraform module for the AWS ALB resource. 
It configures an application load balancer with listeners and target groups as well as a S3 bucket for logging. 

> Note that this module creates an ALB that takes HTTP / HTTPS incoming requests and forward it as HTTP request to the attached servers. 

## Usage

```terraform
module "alb" {
  source = "github.com/rampart81/terraform-modules//alb"
  
  name                                 = "alb"
  internal                             = false
  subnet_ids                           = ["${aws_subnet.public.id}"]
  enable_access_log                    = true
  target_port                          = "8080"
  target_group_vpc_id                  = "${aws_vpc.main.id}"
  health_check_interval                = 30
  health_check_path                    = "/health"
  healthy_threshold                    = 3
  unhealthy_threshold                  = 3
  matcher                              = "200"
  target_count                         = 1
  target_ids                           = ["${aws_instance.app.*.id}"]
  target_port                          = "8080"
  enable_https_listener                = true
  enable_http_listener                 = true
  alb_account_id                       = "600734575887" # Seoul LB Account ID
  log_transition_days                  = 30
  log_transition_storage_class         = "GLACIER"
  expiration                           = 90
  enable_http_egress                   = true
  http_source_egress_security_group_id = "${aws_security_group.app.id}"
  ingress_cidr_blocks                  = ["0.0.0.0/0"]
  ssl_policy                           = "ELBSecurityPolicy-2016-08"
  certificate_arn                      = "${data.aws_acm_certificate.domain.arn}"
}
```

## Variables

```terraform
variable "name"                                 { }

# Set it true if the ALB needs to be internal 
variable "internal"                             { default = false }

# Subnet ids the ALB belongs to 
variable "subnet_ids"                           { type = "list" }

# If set to true, this module creates a S3 bucket to store access logs
variable "enable_access_log"                    { }

# VPC ID which a target group belongs to 
variable "target_group_vpc_id"                  { }

# Count of EC2 instances attachd to the target group
variable "target_count"                         { }

# EC2 instance ids to attach to the target group
variable "target_ids"                           { type = "list" }

# Port number to forward traffic to
variable "target_port"                          { }

variable "health_check_interval"                { }
variable "health_check_path"                    { }
variable "healthy_threshold"                    { }
variable "unhealthy_threshold"                  { }

# Status code for the health check. Default to 200.
variable "matcher"                              { default = "200" }

# If set true, the ALB creates a listener that takes HTTPS requests on 443
variable "enable_https_listener"                { }

# If set true, the ALB creates a listener that takes HTTP requests on 80 port
variable "enable_http_listener"                 { }

# ALB Account ID in AWS. This is used for access log S3 bucket.
# For Seoul, ALB account is is 600734575887
variable "alb_account_id"                       { default = "600734575887" }

# Access log Settings
variable "log_transition_days"                  { default = 30 }
variable "log_transition_storage_class"         { default = "GLACIER" }
variable "expiration"                           { default = 90 }

# If set to true, a security group rule for http egress is created. 
# Should be set to true. 
variable "enable_http_egress"                   { default = true }

# Security group id of attaches servers to forward requests to
variable "http_source_egress_security_group_id" { }

# CIDR Blocks to allow incoming requests. 
variable "ingress_cidr_blocks"                  { default = ["0.0.0.0/0"] }

# Allowed port for incoming http requests
variable "http_ingress_port"                    { default = 80 }

# If the internal option is set to true, set security group ids to allow incoming requests
# from instead of CIDR blocks.
variable "https_ingress_source_sg"              { default = "" }
variable "http_ingress_source_sg"               { default = "" }

# If HTTPS listener is enabled, SSL Policy and Certification ARN (from the AWS  certification manager) should be definied.
variable "ssl_policy"                           { default = "" }
variable "certificate_arn"                      { default = "" }
```

## Outputs

* `security_group_id`: Security group id that ALB belongs to 
* `id`: ALB ID
* `arn`: ALB ARN
* `arn_suffix`
* `"dns_name` 
* `canonical_hosted_zone_id` 
* `zone_id` 
* `http_listener_arn` 
* `https_listener_arn` 
