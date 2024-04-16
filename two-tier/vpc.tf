resource "aws_vpc" "main"{
    cidr_block = "10.100.0.0/16"

    tags = {
        Name = "DEV VPC"
    }
}

resource "aws_subnet" "public_subnets"{
    count = length(var.public_subnet_cidrs)
    cidr_block = var.public_subnet_cidrs[count.index]
    availability_zone = var.azs[count.index]
    vpc_id = aws_vpc.main.id


tags = {
        Name = "Public subnet ${count.index +1}"
        AZ = var.azs[count.index]
    }
    
}

resource "aws_subnet" "private_subnets"{
    count = length(var.private_subnet_cidrs)
    cidr_block = var.private_subnet_cidrs[count.index]
    availability_zone = var.azs[count.index]
    vpc_id = aws_vpc.main.id

tags = {
        Name = "Private subnet ${count.index +1}"
        AZ = var.azs[count.index]
    }
    
}

output "public_subnets" {
    value = aws_subnet.public_subnets
}

output "private_subnets" {
    value = aws_subnet.private_subnets
}


resource "aws_route_table" "Private-RT" {
    vpc_id = aws_vpc.main.id

    dynamic "route"{
        for_each = var.private_subnet_cidr_map

        content {
            cidr_block = route.value
        }
    }
    
}


#TO-DO
# Error: creating route: one of `carrier_gateway_id, core_network_arn, egress_only_gateway_id, gateway_id, local_gateway_id, nat_gateway_id, network_interface_id, transit_gateway_id, vpc_endpoint_id, vpc_peering_connection_id` must be specified
