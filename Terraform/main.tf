
provider "aws" {
  region = "ap-south-1"
  profile = "tf-user"

}

resource "aws_iam_user" "u1" {
  name = "steve"
}

resource "aws_iam_user" "u2" {
  name = "tony"
}

resource "aws_iam_user" "u3" {
  name = "thor"
}

resource "aws_iam_group" "grp" {
  name = "avengers"
}

resource "aws_iam_group_membership" "demo" {
     name = "demo-group"

    users = [
    aws_iam_user.u1.name,
    aws_iam_user.u2.name,
    aws_iam_user.u3.name
  ]
    group = aws_iam_group.grp.name
}

resource "aws_s3_bucket" "bucky" {
  bucket = "www.gharjao.com"

}


resource "aws_instance" "vm" {
  ami = "ami-0ec0e125bb6c6e8ec"
  instance_type = "t2.micro"
  key_name = "tf-key"

  tags = {
    Name = "Anuradha"
  }
}
















