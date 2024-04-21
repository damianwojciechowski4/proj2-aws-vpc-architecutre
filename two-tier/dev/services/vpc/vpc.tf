resource "aws_vpc" "main"{
    cidr_block = "10.100.0.0/16"

    tags = {
        Name = "DEV VPC 2tier"
    }
}

resource "aws_subnet" "public_subnets"{
    count = length(var.public_subnet_cidrs)
    cidr_block = var.public_subnet_cidrs[count.index]
    availability_zone = var.azs[count.index]
    vpc_id = aws_vpc.main.id


tags = {
        Name = "Public subnet ${count.index +1} 2tier"
        AZ = var.azs[count.index]
    }
    
}

resource "aws_subnet" "private_subnets"{
    count = length(var.private_subnet_cidrs)
    cidr_block = var.private_subnet_cidrs[count.index]
    availability_zone = var.azs[count.index]
    vpc_id = aws_vpc.main.id

tags = {
        Name = "Private subnet ${count.index +1} 2tier"
        AZ = var.azs[count.index]
    }
    
}
