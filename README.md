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
## 4 VPCs
### Subnets
- public-subnet-1a 10.100.0.0/24
- public-subnet-1b 10.100.1.0/24
- private-subnet-1a 10.100.100.0/24
- private-subnet-1b 10.100.101.0/24


## Create Route table for private subnets
Private-RT
Associate subnets to the route table
- private-subnet-1a
- private-subnet-1b

## Name MAIN route table as:
Public-RT

## Internet Gateway
### Create Internet Gateway
MyIGW
### Attach IGW to VPC
MyIGW -> whole VPC

## Configure Public-RT with default gateway that points to Internet Gateway


## Configure NAT Gateway
MyNAT_GW

## NAT Gateway
### Configure NAT Gateway
- attach NAT Gateway to public subnet in 1a
- configure default route 0.0.0.0/0 in Private-RT that points to NAT Gateway

## Create security group for public web access



#### Check your public IP on Private 1B instance
<sub>dig +short myip.opendns.com @resolver1.opendns.com</sup>

- [ec2-user@ip-10-100-101-39 ~]$ dig +short myip.opendns.com @resolver1.opendns.com
 **3.72.195.120**


### Create Private Security Group
Create Security Group for Apps



# VPC Peering
VPC Prod 10.200.0.0/16

## Create Peering Connections
## Create Endpoint
- interface endpoint
- gateway endpoint


## SSL VPN
AWS Client VPN

## Site-to-Site VPN
