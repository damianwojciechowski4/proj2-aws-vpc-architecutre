putput "vpc_id" {
    value = aws_vpc.main
}
output "public_subnets" {
    value = aws_subnet.public_subnets[*].id
}

output "private_subnets" {
    value = aws_subnet.private_subnets[*].id
}

output "Private-RT-ID" {
    value = aws_route_table.Private-RT.id
}

output "Public-RT-ID" {
    value = aws_route_table.Public-RT.id
}

output "internet_gateway_id" {
    value = aws_internet_gateway.igw.id
}

output "nat_gateway_id" {
    value = aws_nat_gateway.natgw_2tier.id
}


