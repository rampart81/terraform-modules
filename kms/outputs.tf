output "arn" { 
  value = "${aws_kms_key.master.arn}"
}

output "alias_arn" { 
  value = "${aws_kms_alias.master.arn}"
}

output "key_id" { 
  value = "${aws_kms_key.master.key_id}"
}
