resource "aws_vpc" "my_vpc_devops" {
  cidr_block       = "11.0.0.0/16"
  instance_tenancy = "default"
  tags = {
    Name = "devops_demo_tf"
  }
}

resource "aws_security_group" "devops_secure_group" {
name = "devops_secure_group"
description = "Allow TLS inbound traffic"
vpc_id = aws_vpc.my_vpc_devops.id


  dynamic "ingress" {
    for_each = ["80", "443", "8080", "8081"]
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  ingress {
    from_port   = 22
    to_port     = 22
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