terraform {
  backend "s3" {
    bucket = "devops-b36-tf-backend"
    key    = "terraform.tfstate"
    region = "ap-south-1"
  }
}
