provider "aws" {
  region  = var.region
  profile= "default"
}

resource "aws_vpc" "stage-vpc" {
  cidr_block       = var.vpc-cidr
  instance_tenancy = var.tenancy
  enable_dns_hostnames= true

  tags = {
    Name = "stage-vpc"
  }
}

resource "aws_internet_gateway" "stage-igw" {
  vpc_id = aws_vpc.stage-vpc.id

  tags = {
    Name = "stage-igw"
  }
}

resource "aws_subnet" "pub-sub-stage" {
  vpc_id     = aws_vpc.stage-vpc.id
  cidr_block = var.sub-cidrs
  availability_zone= "ap-south-1a"
  map_public_ip_on_launch= true
  tags = {
    Name = "pub-sub-stage"
  }
}

resource "aws_route_table" "stage-pub-rt" {
  vpc_id = aws_vpc.stage-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.stage-igw.id
  }


  tags = {
    Name = "stage-pub-rt"
  }
}

resource "aws_route_table_association" "ass" {
  subnet_id      = aws_subnet.pub-sub-stage.id
  route_table_id = aws_route_table.stage-pub-rt.id
}


resource "aws_security_group" "ssh-sg" {
  name        = "ssh-sg-5"
  description = "Allow SSH inbound traffic"
  vpc_id      = aws_vpc.stage-vpc.id

  ingress {
    # TLS (change to whatever ports you need)
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    # Please restrict your ingress to only necessary IPs and ports.
    # Opening to 0.0.0.0/0 can lead to security vulnerabilities.
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}
