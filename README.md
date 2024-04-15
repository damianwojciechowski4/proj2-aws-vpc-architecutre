# proj2-aws-vpc-architecutre


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

## Configure NAT Gateway
MyNAT_GW

## Configure Public-RT with default gateway that points to Internet Gateway




## NAT Gateway
### Configure NAT Gateway
- attach NAT Gateway to public subnet in 1a
- configure default route 0.0.0.0/0 in Private-RT that points to NAT Gateway

## Create security group for public web access


## EC2 Instance
### AMI ID: ami-0a23a9827c6dab833

**aws ec2 run-instances --image-id <value> \
--instance-type --security-group-ids <value> \
--subnet-id <value> \
--key-name <value> \
--user-data file://<value> \
 --metadata-options "HttpEndpoint=enabled,HttpTokens=required"**


## Launch instance in Public1A
<sub>aws ec2 run-instances --image-id ami-0a23a9827c6dab833 \
--instance-type t2.micro \
 --security-group-ids sg-0283f5187e376a357 \
 --subnet-id subnet-0cebede28f68b7af7 \
 --key-name EC-PEM-key \
 --user-data file://user-data-subnet-id.txt \
 --metadata-options "HttpEndpoint=enabled,HttpTokens=required"</sup>



## Launch instance in Private 1A


## Launch instance in Public 1B
<sub>aws ec2 run-instances --image-id ami-0a23a9827c6dab833 \
--instance-type t2.micro \
 --security-group-ids sg-0283f5187e376a357 \
 --subnet-id subnet-0fce7659a322e4789 \
 --key-name EC-PEM-key \
 --user-data file://user-data-subnet-id.txt \
 --metadata-options "HttpEndpoint=enabled,HttpTokens=required"</sup>




## Launch instance in Private 1B
<sub>aws ec2 run-instances --image-id ami-0a23a9827c6dab833 \
--instance-type t2.micro \
 --security-group-ids sg-0283f5187e376a357 \
 --subnet-id subnet-0350f490ed359551c \
 --key-name EC-PEM-key \
 --user-data file://user-data-subnet-id.txt \
 --metadata-options "HttpEndpoint=enabled,HttpTokens=required"</sup>


#### Check your public IP on Private 1B instance
<sub>dig +short myip.opendns.com @resolver1.opendns.com</sup>

- [ec2-user@ip-10-100-101-39 ~]$ dig +short myip.opendns.com @resolver1.opendns.com
 **3.72.195.120**


### Create Private Security Group
Create Security Group for Apps



### Remove instance with CLI command

aws ec2 terminate-instances --instance-ids <value> <value>

aws ec2 terminate-instances --instance-ids "i-038e28f6119c151be"


# VPC Peering
VPC Prod 10.200.0.0/16

- Owner ID: 058264462678
- VPC ID: vpc-061fa8346c1672bf3
## Create Peering Connections
## Create Endpoint
- interface endpoint
- gateway endpoint


## SSL VPN
AWS Client VPN

## Site-to-Site VPN
