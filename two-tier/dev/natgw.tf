# Configure NAT gateway and attach elastic IP

resource "aws_nat_gateway" "natgw_2tier" {
    allocation_id = aws_eip.nat_eip_2tier.id
    subnet_id = aws_subnet.public_subnets[0].id


    tags = {
        Name = "NAT gateway eu-central-1a"
    }


    depends_on = [aws_internet_gateway.igw]
}

resource "aws_eip" "nat_eip_2tier" {
    domain = "vpc"
}


output "nat_gateway_id" {
    value = aws_nat_gateway.natgw_2tier.id
}