output "vpc_id" { 
  value = "${aws_vpc.vpc.id}"
}

output "vpc_cidr_block" {
  value = "${aws_vpc.vpc.cidr_block}"
}

output "public_availability_zone1_subnet_id" {
  value = "${aws_subnet.public_availability_zone1.id}" 
}

output "public_availability_zone2_subnet_id" {
  value = "${aws_subnet.public_availability_zone2.id}" 
}

output "public_subnet_ids" { 
  value = [
    "${aws_subnet.public_availability_zone1.id}",
    "${aws_subnet.public_availability_zone2.id}"
  ] 
}

output "private_availability_zone1_subnet_id" {
  value = "${aws_subnet.private_availability_zone1.id}" 
}

output "private_availability_zone2_subnet_id" {
  value = "${aws_subnet.private_availability_zone2.id}" 
}

output "private_subnet_ids" { 
  value = [
    "${aws_subnet.private_availability_zone1.id}",
    "${aws_subnet.private_availability_zone2.id}"
  ] 
}

output "public_route_table_id" {
  value =  "${aws_default_route_table.default.id}"
}

output "private_route_table_id" {
  value = "${aws_route_table.private.id}"
}
