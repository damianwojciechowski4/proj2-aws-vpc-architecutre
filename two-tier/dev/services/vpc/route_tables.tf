resource "aws_route_table" "Private-RT" {
    vpc_id = aws_vpc.main.id

    tags = {
        Name = "private-rt-eu-central1-dev"
    }
    
}

resource "aws_route_table_association" "Private-RT-Association"{
    count = length(var.private_subnet_cidrs)
    subnet_id = element(aws_subnet.private_subnets[*].id, count.index)
    route_table_id = aws_route_table.Private-RT.id
}

resource "aws_route" "Private-RT-to-NATGW" {
    route_table_id = aws_route_table.Private-RT.id
    destination_cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.natgw_2tier.id
}

resource "aws_route_table" "Public-RT" {
    vpc_id = aws_vpc.main.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }

    tags = {
        Name = "public-rt-eu-central1-dev"
    }
    
}

resource "aws_route_table_association" "Public-RT-Association"{
    count = length(var.public_subnet_cidrs)
    subnet_id = element(aws_subnet.public_subnets[*].id, count.index)
    route_table_id = aws_route_table.Public-RT.id
}