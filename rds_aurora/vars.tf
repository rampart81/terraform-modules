variable "name" {
}

variable "subnet_ids" {
  type = list(string)
}

variable "db_parameter_group_family" {
}

variable "instance_class" {
}

variable "master_username" {
}

variable "master_password" {
}

variable "apply_immediately" {
}

variable "backup_retention_period" {
}

variable "storage_encrypted" {
}

variable "cluster_identifier" {
}

variable "availability_zones" {
  type = list(string)
}

variable "database_name" {
}

variable "preferred_backup_window" {
}

variable "preferred_maintenance_window" {
}

variable "vpc_security_group_ids" {
  type = list(string)
}

variable "cluster_instance_count" {
}

variable "engine" {
  default = "aurora-mysql"
}

variable "engine_version" {
  default = "5.7.mysql_aurora.2.03.2"
}

variable "engine_mode" {
  default = "provisioned"
}

variable "max_allowed_packet" {
  default = "209715200"
}

variable "deletion_protection" {
  default = false
}

