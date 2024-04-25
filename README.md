# proj2-aws-vpc-architecutre

# Terraform resources used
- aws_vpc 
- aws_subnet
- aws_route_table
- aws_route_table_association
- aws_route
- aws_internet_gateway
- aws_nat_gateway
- aws_eip

# AWS VPC deployment IaC configures below components
## 1 VPC - 10.100.0.0/16
### 4 Subnets within VPC
- public-subnet-1a 10.100.0.0/24
- public-subnet-1b 10.100.1.0/24
- private-subnet-1a 10.100.100.0/24
- private-subnet-1b 10.100.101.0/24


## Create Route table for private subnets
- private-rt-eu-central1-dev
### Associate subnets to the route table
- private-subnet-1a
- private-subnet-1b

## Name MAIN route table as:
- public-rt-eu-central1-dev

## Internet Gateway
igw-eu-central-1-dev
### Attach IGW to VPC
igw-eu-central-1-dev -> whole VPC

## Configure Public-RT with default gateway that points to Internet Gateway

## Configure NAT Gateway
nat-gw-eu-central-1a-dev

## NAT Gateway
### Configure NAT Gateway
- attach NAT Gateway nat-gw-eu-central-1a-dev to public subnet in AZ eu-central-1a
- configure default route 0.0.0.0/0 in Private-RT that points to NAT Gateway

## Create security group for public access
- allow access to public Bastion server on port TCP_22 [SSH]

## Create security group for private access
- allow access from Bastion server to private server on port TCP_22[SSH] that is directed from
security-group-eu-central1-dev-public 


#### Check your public IP on Private 1a instance
<sup>dig +short myip.opendns.com @resolver1.opendns.com</sup>

[ec2-user@ip-10-100-100-51 ~]$  dig +short myip.opendns.com @resolver1.opendns.com
<sup>18.197.240.14</sup>
