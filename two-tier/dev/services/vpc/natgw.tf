# Configure NAT gateway and attach elastic IP

resource "aws_nat_gateway" "natgw_2tier" {
    allocation_id = aws_eip.nat_eip_2tier.id
    subnet_id = aws_subnet.public_subnets[0].id
    tags = {
        Name = "nat-gw-eu-central-1a-dev"
    }
    depends_on = [aws_internet_gateway.igw]
}

resource "aws_eip" "nat_eip_2tier" {
    domain = "vpc"
    tags = {
        Name = "eip-eu-central-1a-dev"
    }
}


