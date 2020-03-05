output "vpc_id" { 
  value = "${aws_vpc.vpc.id}"
}

output "vpc_cidr_block" {
  value = "${aws_vpc.vpc.cidr_block}"
}

output "public_subnet_ids" {
  value = [ for subnet in aws_subnet.public_availability_zones: subnet.id ]
}

output "private_subnet_ids" { 
  value = [ for subnet in aws_subnet.private_availability_zones: subnet.id ]
}

output "public_route_table_id" {
  value =  "${aws_default_route_table.default.id}"
}

output "private_route_table_id" {
  value = "${aws_route_table.private.id}"
}

output "nat_gateway_public_ip" {
  value = "${aws_nat_gateway.nat.public_ip}"
}
