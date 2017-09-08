resource "aws_kms_key" "master" {
  description             = "${var.description}"
  deletion_window_in_days = "${var.deletion_window_in_days}"
  policy                  = "${var.policy}"
  is_enabled              = "${var.is_enabled}"
  enable_key_rotation     = "${var.enable_key_rotation}"
  
  tags {
    Name = "${var.name}" 
  }    
}

resource "aws_kms_alias" "master" {
  name          = "alias/${var.name}"
  target_key_id = "${aws_kms_key.master.key_id}"
}
