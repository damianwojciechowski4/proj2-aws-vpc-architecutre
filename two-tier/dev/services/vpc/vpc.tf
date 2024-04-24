resource "aws_vpc" "main"{
    cidr_block = "10.100.0.0/16"

    tags = {
        Name = "vpc-eu-central-1-dev-2tier"
    }
}

#Retrieve the list of AZs in the current region
data "aws_availability_zones" "available" {
  state = "available"
}
resource "aws_subnet" "public_subnets"{
    count = length(var.public_subnet_cidrs)
    cidr_block = var.public_subnet_cidrs[count.index]
    availability_zone = var.azs[count.index]
    vpc_id = aws_vpc.main.id


tags = {
        Name = "subnet-eu-central-${var.azs[count.index]}-public-dev"
        AZ = var.azs[count.index]
    }
    
}

resource "aws_subnet" "private_subnets"{
    count = length(var.private_subnet_cidrs)
    cidr_block = var.private_subnet_cidrs[count.index]
    availability_zone = var.azs[count.index]
    vpc_id = aws_vpc.main.id

tags = {
        Name = "subnet-eu-central-${var.azs[count.index]}-private-dev"
        AZ = var.azs[count.index]
    }
    
}
