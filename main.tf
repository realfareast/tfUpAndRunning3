provider "aws" {
  region = "us-east-2"
}

locals {
  ami = {
    Ubuntu_Server_24_04_LTS_HVM_SSD_Volume_Type = "ami-0d1b5a8c13042c939"
  }
}

resource "aws_instance" "example" {
  ami           = local.ami.Ubuntu_Server_24_04_LTS_HVM_SSD_Volume_Type
  instance_type = "t2.micro"
  vpc_security_group_ids = [ aws_security_group.instance.id ]

  user_data = <<-EOF
                #!/bin/bash
                echo "Hello, World" > index.html
                nohup busybox httpd -f -p 8080 &
                EOF

  user_data_replace_on_change = true

  tags = {
    Name = "terraform-example"
  }
}

resource "aws_security_group" "instance" {
  name = "terraform-example-instance"

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}