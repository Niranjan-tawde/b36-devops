resource "aws_vpc" "vnet" {
  cidr_block = var.vpc_cidr_block

  tags = {
    Name = "VPC-TF"
  }
}


resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.vnet.id
  cidr_block              = var.cidr_block
  availability_zone       = var.availability_zone[0]
  map_public_ip_on_launch = var.public_ip

  tags = {
    Name = "Public-Subnet"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vnet.id

  tags = {
    Name = "IGW-TF"
  }
}

resource "aws_route_table" "RT" {
  vpc_id = aws_vpc.vnet.id
  tags = {
    Name = "RT-PUBLIC"
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "RTA" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.RT.id
}

resource "aws_security_group" "sg" {
  name   = "tf-sg"
  vpc_id = aws_vpc.vnet.id


  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}
