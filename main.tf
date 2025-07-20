provider "aws" {
    region = "us-east-2"
}

locals {
  ami = {
    Ubuntu_Server_24_04_LTS_HVM_SSD_Volume_Type = "ami-0d1b5a8c13042c939"
  }
}

resource "aws_instance" "example" {
    ami = local.ami.Ubuntu_Server_24_04_LTS_HVM_SSD_Volume_Type
    instance_type = "t2.micro"
    tags = {
      Name = "terraform-example"
    }
}