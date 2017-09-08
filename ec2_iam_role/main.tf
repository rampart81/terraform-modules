###########################################################
## EC2 Role & Policy
###########################################################
resource "aws_iam_role" "ec2_iam_role" {
  name               = "${var.name}_iam_role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_instance_profile" "ec2_iam_profile" {
  name = "${var.name}_iam_profile"
  role = "${aws_iam_role.ec2_iam_role.name}"
}

resource "aws_iam_role_policy" "ec2_iam_role_policy" {
  name   = "${var.name}_iam_role_policy"
  role   = "${aws_iam_role.ec2_iam_role.id}"
  policy = "${var.iam_role_policy}"
}
