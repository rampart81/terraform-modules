output "security_group_id" {
  value = "${aws_security_group.alb.id}"
}

output "id" {
  value = "${aws_alb.alb.id}" 
}

output "arn" {
  value = "${aws_alb.alb.arn}" 
}

output "arn_suffix" {
  value = "${aws_alb.alb.arn_suffix}" 
}

output "dns_name" {
  value = "${aws_alb.alb.dns_name}" 
}

output "canonical_hosted_zone_id" {
  value = "${aws_alb.alb.canonical_hosted_zone_id}"
}

output "zone_id" {
  value = "${aws_alb.alb.zone_id}"
}

output "http_listener_arn" {
  value = "${aws_alb_listener.http.arn}"
}

output "https_listener_arn" {
  value = "${aws_alb_listener.https.arn}"
}
