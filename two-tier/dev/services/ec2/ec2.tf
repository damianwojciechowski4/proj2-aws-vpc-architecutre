data "aws_vpc" "dev" {
    id = var.vpc_id
}

data "aws_subnets" "public" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }

  tags = {
    Name = "*public-dev"
  }
}

data "aws_subnet" "public" {
  for_each = toset(data.aws_subnets.public.ids)
  id       = each.value
}

data "aws_subnets" "private" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }

  tags = {
    Name = "*private-dev"
  }
}

data "aws_subnet" "private" {
  for_each = toset(data.aws_subnets.private.ids)
  id       = each.value
}

#Retrieve the list of AZs in the current region
data "aws_availability_zones" "available" {
  state = "available"
}

#Create key apir for EC2 instance
resource "aws_key_pair" "test_key" {
  key_name   = "ec2_pubkey-vpc-dev"
  public_key = file ("../../../../../PuttyKeys/proj2-vpc/ec2-vpc-proj2.pub")
}

resource "aws_security_group" "public_sg" {
  name = "security-group-eu-central1-dev-public"
  vpc_id = var.vpc_id
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
}
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
   }
}


resource "aws_security_group" "private_sg" {
  name = "security-group-eu-central1-dev-private"
  vpc_id = var.vpc_id
    ingress {
      from_port = 22
      to_port = 22
      protocol = "tcp"
      security_groups = [aws_security_group.public_sg.id]
            }

    egress {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
   }
}

resource "aws_instance" "public" {
  ami = "ami-0f673487d7e5f89ca"
  instance_type = "t2.micro"
  subnet_id = values(data.aws_subnet.public)[0].id
  associate_public_ip_address = true
  vpc_security_group_ids =[aws_security_group.public_sg.id]
  key_name = aws_key_pair.test_key.key_name
  
  tags = {
      Name = "ec2-eu-central1-${data.aws_availability_zones.available.names[0]}-dev-public"
      }
}

resource "aws_instance" "private" {
  ami = "ami-0f673487d7e5f89ca"
  instance_type = "t2.micro"
  subnet_id = values(data.aws_subnet.private)[0].id
  vpc_security_group_ids =[aws_security_group.private_sg.id]
  key_name = aws_key_pair.test_key.key_name
  tags = {
    Name = "ec2-eu-central1-${data.aws_availability_zones.available.names[0]}-dev-private"
}
}



