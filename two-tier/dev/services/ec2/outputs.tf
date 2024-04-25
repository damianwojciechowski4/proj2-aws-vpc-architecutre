output "subnet_cidr_blocks_public" {
    value = [for subnet in data.aws_subnet.public : subnet.cidr_block]
}


output "subnet_cidr_blocks_private" {
    value = [for subnet in data.aws_subnet.private : subnet.cidr_block]
}



output "public_ip" {
    value = aws_instance.public.public_ip
    description = "The public IP address of the Bastion EC2 instance"
}


output "private_ip" {
    value = aws_instance.private.private_ip
    description = "The private IP address of EC2 instance"
}