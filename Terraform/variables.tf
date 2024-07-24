resource "aws_instance" "local" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name
  tags          = var.tags

}

variable "ami_id" {
  type    = string
  default = "ami-0ec0e125bb6c6e8ec"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"

}

variable "key_name" {
  type    = string
  default = "tf-key"

}


variable "tags" {
  type = map(string)
  default = {
    "Name" = "Var-Instance"
  }

}
