data "aws_vpc" "dev" {
    id = var.vpc_id
}

data "aws_subnets" "public" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }

  tags = {
    Name = "Public subnet*"
  }
}

data "aws_subnet" "public" {
  for_each = toset(data.aws_subnets.public.ids)
  id       = each.value
}
#this can be directly used:
#https://stackoverflow.com/questions/48817967/aws-terraform-filter-specific-subnets-by-matching-substring-in-tag-name

data "aws_subnets" "private" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }

  tags = {
    Name = "Private subnet*"
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
  key_name   = "test_key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEAqijjKW0GCpgp1zzFlPeWi5R+LUJ8wiKxLTd+dkV+eoROEplWHCmnVOo8u8rpyQQFUn7dg7Tsz5YaHRCeKCAEeFFZsX/siOirp8/ujm+TWCfgfEXcveKIVBtZeKvvYca+gGhIBK3cfg6hPnY+TN2RWp+g1stSnY5PnEVy9LFScyLaaLV6s7WdxWlzaEG43EEyND8C+EysxF/sT1FmHL4ILxRzxcVIBqoiGmR3GCBvynvPHuYdp4sCvXLwXOqSMtYaTEWDn3j8Jov2EdUw3tJxuEJ7mLnJ0jCq6dRCfxyOtxDrPP2UpAF6mYn25lHBBghR31x8BrIgBWW6IVS0tLvORQ=="
}

resource "aws_security_group" "public_sg" {
  name = "new-terraform-public_sg"
  vpc_id = var.vpc_id
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
}
}


resource "aws_security_group" "private_sg" {
  name = "new-terraform-private_sg"
  vpc_id = var.vpc_id
    ingress {
      from_port = 22
      to_port = 22
      protocol = "tcp"
      security_groups = [aws_security_group.public_sg.id]
            }
}

resource "aws_instance" "public" {
  ami = "ami-04dfd853d88e818e8"
  instance_type = "t2.micro"
  subnet_id = values(data.aws_subnet.public)[0].id
  associate_public_ip_address = true
  vpc_security_group_ids =[aws_security_group.public_sg.id]
  key_name = aws_key_pair.test_key.key_name
  
  tags = {
      Name = "Public Instance ${data.aws_availability_zones.available.names[0]}"
      }
}

resource "aws_instance" "private" {
  ami = "ami-04dfd853d88e818e8"
  instance_type = "t2.micro"
  subnet_id = values(data.aws_subnet.private)[0].id
  vpc_security_group_ids =[aws_security_group.private_sg.id]
  key_name = aws_key_pair.test_key.key_name
  tags = {
    Name = "Private Instance ${data.aws_availability_zones.available.names[0]}"
}
}



