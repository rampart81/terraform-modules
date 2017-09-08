output "vpc_peering_id" { 
  value = "${aws_vpc_peering_connection.vpc_peering.id}"
}

output "vpc_peering_accept_status" { 
  value = "${aws_vpc_peering_connection.vpc_peering.accept_status}"
}
