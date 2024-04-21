data "aws_vpc" "dev" {
    id = var.vpc_id
}


data "aws_subnet_ids" "example" {
    vpc_id = var.vpc_id
}


data "aws_subnet" "example" {
    for_each = data.aws_subnet_ids.example.ids
    id = each.value
}
