output "security_group_id" {
  value = aws_security_group.alb.id
}

output "id" {
  value = aws_alb.alb.id
}

output "arn" {
  value = aws_alb.alb.arn
}

output "arn_suffix" {
  value = aws_alb.alb.arn_suffix
}

output "dns_name" {
  value = aws_alb.alb.dns_name
}

output "zone_id" {
  value = aws_alb.alb.zone_id
}

