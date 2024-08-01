data "aws_ami" "amzlx" {
  most_recent = true

  filter {
    name   = "name"
    values = ["al2023-ami-2023.5.20240722.0-kernel-6.1-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name  = "root-device-type"
    values = ["ebs"]
  }

  owners = ["137112412989"] # Canonical
}

resource "aws_instance" "web" {
  count = 3
  ami           = data.aws_ami.amzlx.id
  instance_type = "t3.micro"

  tags = {
    Name = "Server- ${count.index}"
  }
}



output "ami" {
  value = data.aws_ami.amzlx.id
}

