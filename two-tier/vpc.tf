resource "aws_vpc" "main"{
    cidr_block = "10.100.0.0/16"
}

resource "aws_subnet" "public_subnets"{
    count = length(var.public_subnet_cidrs)
    cidr_block = var.public_subnet_cidrs[count.index]
    availability_zone = var.azs[count.index]
    vpc_id = aws_vpc.main.id
    
}
resource "aws_subnet" "private_subnets"{
    count = length(var.private_subnet_cidrs)
    cidr_block = var.private_subnet_cidrs[count.index]
    availability_zone = var.azs[count.index]
    vpc_id = aws_vpc.main.id
    
}

output "public_subnets" {
    value = aws_subnet.public_subnets
}

output "private_subnets" {
    value = aws_subnet.private_subnets
}

