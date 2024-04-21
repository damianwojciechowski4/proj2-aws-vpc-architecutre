variable "public_subnet_cidrs"{
    description = "Public Subnet CIDR"
    type = list(string)
    default = ["10.100.0.0/24","10.100.1.0/24"]
}

variable "private_subnet_cidrs"{
    description = "Private Subnet CIDR"
    type = list(string)
    default = ["10.100.100.0/24","10.100.101.0/24"]
}



variable "public_subnet_cidr_map" {
  type    = map(string)
  default = { "eu-central-1a" = "10.100.100.0/24", "eu-central-1b" = "10.100.1.0/24" }
}

variable "private_subnet_cidr_map" {
  type    = map(string)
  default = { "eu-central-1a" = "10.100.0.0/24", "eu-central-1b" = "10.100.101.0/24" }
}




variable "azs"{
    type = list(string)
    description = "Availability zones of eu-central"
    default = ["eu-central-1a" , "eu-central-1b"]
}