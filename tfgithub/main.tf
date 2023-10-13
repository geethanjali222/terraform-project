provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "example" {
  ami           = "ami-041feb57c611358bd"
  instance_type = "t2.micro"

  tags = {
    Name = "var.ec2_name"
  }
}
