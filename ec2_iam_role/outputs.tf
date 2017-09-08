output "iam_arn" {
  value = "${aws_iam_role.ec2_iam_role.arn}"
}

output "iam_create_date" {
  value = "${aws_iam_role.ec2_iam_role.create_date}"
}

output "iam_unique_id" {
  value = "${aws_iam_role.ec2_iam_role.unique_id}"
}

output "iam_name" {
  value = "${aws_iam_role.ec2_iam_role.name}"
}

output "iam_description" {
  value = "${aws_iam_role.ec2_iam_role.description}"
}

output "iam_profile_id" {
  value = "${aws_iam_instance_profile.ec2_iam_profile.id}"
}
