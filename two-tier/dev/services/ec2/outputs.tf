output "subnet_cidr_blocks_public" {
    value = [for subnet in data.aws_subnet.public : subnet.cidr_block]
}


output "subnet_cidr_blocks_private" {
    value = [for subnet in data.aws_subnet.private : subnet.cidr_block]
}