resource "aws_db_subnet_group" "db" {
  name        = "${var.name}"
  description = "${var.name} RDS Subnet Group"
  subnet_ids  = ["${var.subnet_ids}"]
}

resource "aws_db_parameter_group" "db" {
  name   = "${var.name}"
  family = "${var.db_parameter_group_family}"

  ## Set the max limit packet option.
  parameter {
    name  = "max_allowed_packet"
    value = "${var.max_allowed_packet}"
  }

  ## Change char settings so that korean texts can be written/read properly
  parameter {
    name  = "character_set_server"
    value = "utf8mb4"
  }

  parameter {
    name  = "character_set_client"
    value = "utf8mb4"
  }

  parameter {
    name  = "character_set_connection"
    value = "utf8mb4"
  }

  parameter {
    name  = "character_set_database"
    value = "utf8mb4"
  }

  parameter {
    name  = "character_set_results"
    value = "utf8mb4"
  }

  parameter {
    name  = "collation_connection"
    value = "utf8mb4_general_ci"
  }

  parameter {
    name  = "collation_server"
    value = "utf8mb4_unicode_ci"
  }
}

resource "aws_rds_cluster_parameter_group" "db" {
  name   = "${var.name}"
  family = "${var.db_parameter_group_family}"

  ## Change char settings so that korean texts can be written/read properly
  parameter {
    name  = "character_set_server"
    value = "utf8mb4"
  }

  parameter {
    name  = "character_set_client"
    value = "utf8mb4"
  }

  parameter {
    name  = "character_set_connection"
    value = "utf8mb4"
  }

  parameter {
    name  = "character_set_database"
    value = "utf8mb4"
  }

  parameter {
    name  = "character_set_results"
    value = "utf8mb4"
  }

  parameter {
    name  = "collation_connection"
    value = "utf8mb4_general_ci"
  }

  parameter {
    name  = "collation_server"
    value = "utf8mb4_unicode_ci"
  }
}

resource "aws_rds_cluster" "db" {
  engine                          = "${var.engine}"
  cluster_identifier              = "${var.cluster_identifier}"
  availability_zones              = ["${var.availability_zones}"]
  database_name                   = "${var.database_name}"
  master_username                 = "${var.master_username}"
  master_password                 = "${var.master_password}"
  backup_retention_period         = "${var.backup_retention_period}"
  preferred_backup_window         = "${var.preferred_backup_window}"
  preferred_maintenance_window    = "${var.preferred_maintenance_window}"
  vpc_security_group_ids          = ["${var.vpc_security_group_ids}"]
  storage_encrypted               = "${var.storage_encrypted}"

  db_subnet_group_name            = "${aws_db_subnet_group.db.name}"
  db_cluster_parameter_group_name = "${aws_rds_cluster_parameter_group.db.name}"
}

resource "aws_rds_cluster_instance" "db" {
  engine            = "${var.engine}"
  count             = "${var.cluster_instance_count}"
  identifier        = "${var.cluster_identifier}-${count.index}"
  instance_class    = "${var.instance_class}"
  apply_immediately = "${var.apply_immediately}"

  db_subnet_group_name    = "${aws_db_subnet_group.db.name}"
  cluster_identifier      = "${aws_rds_cluster.db.id}"
  db_parameter_group_name = "${aws_rds_parameter_group.db.name}"
}
