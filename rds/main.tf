resource "aws_db_subnet_group" "db" {
  name        = "${var.name}"
  description = "${var.name} RDS Subnet Group"
  subnet_ids  = ["${var.subnet_ids}"]
}

resource "aws_db_parameter_group" "db" {
  name   = "${var.name}"
  family = "${var.db_parameter_group_family}"

  ## Change char settings so that korean texts can be written/read properly
  parameter {
    name  = "character_set_server"
    value = "utf8"
  }

  parameter {
    name  = "character_set_client"
    value = "utf8"
  }

  parameter {
    name  = "character_set_connection"
    value = "utf8"
  }

  parameter {
    name  = "character_set_database"
    value = "utf8"
  }

  parameter {
    name  = "character_set_results"
    value = "utf8"
  }

  parameter {
    name  = "collation_connection"
    value = "utf8_general_ci"
  }

  parameter {
    name  = "collation_server"
    value = "utf8_unicode_ci"
  }
}

resource "aws_db_instance" "db" {
  allocated_storage                   = "${var.allocated_storage}"
  engine                              = "${var.engine}"
  engine_version                      = "${var.engine_version}"
  instance_class                      = "${var.instance_class}"
  identifier                          = "${var.name}"
  username                            = "${var.username}"
  password                            = "${var.password}"
  iam_database_authentication_enabled = "${var.iam_database_authentication_enabled}"
  vpc_security_group_ids              = ["${var.security_group_ids}"]

  db_subnet_group_name = "${aws_db_subnet_group.db.id}"
  parameter_group_name = "${aws_db_parameter_group.db.id}"

  multi_az            = "${var.multi_az}"
  storage_type        = "${var.storage_type}"
  publicly_accessible = "${var.publicly_accessible}"
  storage_encrypted   = "${var.storage_encrypted}"

  allow_major_version_upgrade = "${var.allow_major_version_upgrade}"
  auto_minor_version_upgrade  = "${var.auto_minor_version_upgrade}"
  apply_immediately           = "${var.apply_immediately}"
  maintenance_window          = "${var.maintenance_window}"
  skip_final_snapshot         = "${var.skip_final_snapshot}"
  copy_tags_to_snapshot       = "${var.copy_tags_to_snapshot}"
  backup_retention_period     = "${var.backup_retention_period}"
  backup_window               = "${var.backup_window}"

  tags { Name = "${var.name}" }
}
