##############################################################
## Access Log S3 Bucket Configuration
##############################################################
resource "aws_s3_bucket" "access_log" {
  count  = "${var.enable_access_log ? 1 : 0}"

  bucket = "lb-log-${var.name}"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::${var.alb_account_id}:root"
      },
      "Action": "s3:PutObject",
      "Resource": "arn:aws:s3:::lb-log-${var.name}/*"
    }
  ]
}
EOF

  lifecycle_rule {
    id      = "log_lifecycle"
    prefix  = ""
    enabled = "${var.enable_access_log}"

    transition {
      days          = "${var.log_transition_days}"
      storage_class = "${var.log_transition_storage_class}"
    }

    expiration {
      days = "${var.expiration}"
    }
  }
}

##############################################################
## ALB Security Group Configuration
##############################################################
resource "aws_security_group" "alb" {
  name        = "${var.name}"
  vpc_id      = "${var.target_group_vpc_id}"
  description = "${var.name} ALB Security Group"
  
  tags      { Name = "${var.name}" }
  lifecycle { create_before_destroy = true }
}

resource "aws_security_group_rule" "https_ingress" {
  count             = "${var.enable_https_listener && ! var.internal ? 1 : 0}"

  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "TCP"
  cidr_blocks       = "${var.ingress_cidr_blocks}"
  security_group_id = "${aws_security_group.alb.id}"

  lifecycle { create_before_destroy = true }
}


resource "aws_security_group_rule" "https_ingress_from_sg" {
  count             = "${var.enable_https_listener && var.internal ? 1 : 0}"

  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "TCP"
  source_security_group_id = "${var.https_ingress_source_sg}"
  security_group_id        = "${aws_security_group.alb.id}"

  lifecycle { create_before_destroy = true }
}

resource "aws_security_group_rule" "http_ingress" {
  count             = "${var.enable_http_listener && ! var.internal ? 1 : 0}"

  type              = "ingress"
  from_port         = "${var.http_ingress_port}"
  to_port           = "${var.http_ingress_port}"
  protocol          = "TCP"
  cidr_blocks       = "${var.ingress_cidr_blocks}"
  security_group_id = "${aws_security_group.alb.id}"

  lifecycle { create_before_destroy = true }
}

resource "aws_security_group_rule" "http_ingress_from_sg" {
  count                    = "${var.enable_http_listener && var.internal ? 1 : 0}"

  type                     = "ingress"
  from_port                = "${var.http_ingress_port}"
  to_port                  = "${var.http_ingress_port}"
  protocol                 = "TCP"
  source_security_group_id = "${var.http_ingress_source_sg}"
  security_group_id        = "${aws_security_group.alb.id}"

  lifecycle { create_before_destroy = true }
}

resource "aws_security_group_rule" "http_egress" {
  count                    = "${var.enable_http_egress ? 1 : 0}"

  type                     = "egress"
  from_port                = "${var.target_port}" 
  to_port                  = "${var.target_port}" 
  protocol                 = "TCP"
  source_security_group_id = "${var.http_source_egress_security_group_id}"
  security_group_id        = "${aws_security_group.alb.id}"

  lifecycle { create_before_destroy = true }
}

##############################################################
## ALB Configuration
##############################################################
resource "aws_alb" "alb" {
  name            = "${var.name}"
  internal        = "${var.internal}"
  security_groups = ["${aws_security_group.alb.id}"]
  subnets         = ["${var.subnet_ids}"]

  access_logs {
    bucket  = "${aws_s3_bucket.access_log.id}"
    prefix  = "${var.name}_lb_log"
    enabled = "${var.enable_access_log}"
  }

  tags {
    Name = "${var.name}"
  }

  lifecycle { create_before_destroy = true }
}

##############################################################
## ALB Target Group Configuration
##############################################################
resource "aws_alb_target_group" "alb" {
  name     = "${var.name}"
  port     = "${var.target_port}"
  protocol = "HTTP"
  vpc_id   = "${var.target_group_vpc_id}"

  health_check {
    interval            = "${var.health_check_interval}"
    path                = "${var.health_check_path}"
    port                = "${var.target_port}"
    healthy_threshold   = "${var.healthy_threshold}"
    unhealthy_threshold = "${var.unhealthy_threshold}"
    matcher             = "${var.matcher}"
  }

  tags { Name = "${var.name}" }
}

resource "aws_alb_target_group_attachment" "alb" {
  count            = "${var.target_count}"
  target_group_arn = "${aws_alb_target_group.alb.arn}"
  target_id        = "${element(var.target_ids, count.index)}"
  port             = "${var.target_port}"
}

##############################################################
## ALB Listener Configuration
##############################################################
resource "aws_alb_listener" "https" {
  count             = "${var.enable_https_listener ? 1 : 0}"
  load_balancer_arn = "${aws_alb.alb.arn}"
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "${var.ssl_policy}"
  certificate_arn   = "${var.certificate_arn}"

  default_action {
    target_group_arn = "${aws_alb_target_group.alb.arn}"
    type             = "forward"
  }
}

resource "aws_alb_listener" "http" {
  count             = "${var.enable_http_listener ? 1 : 0}"
  load_balancer_arn = "${aws_alb.alb.arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_alb_target_group.alb.arn}"
    type             = "forward"
  }
}


