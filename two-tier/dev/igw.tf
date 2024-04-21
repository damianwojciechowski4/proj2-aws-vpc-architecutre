resource "aws_internet_gateway" "igw"{
    vpc_id = aws_vpc.main.id

    tags = {
        Name = "DEV IGW"
    }
}


output "internet_gateway_id" {
    value = aws_internet_gateway.igw.id
}