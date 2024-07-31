variable "vpc_cidr_block" {
  type = string
}

variable "cidr_block" {
  type = string

}


variable "availability_zone" {
  type = list(string)

}

variable "public_ip" {
  type = bool
}
