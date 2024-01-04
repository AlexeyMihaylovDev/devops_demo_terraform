resource "aws_instance"  "ubuntu_instance" {
  ami           = var.ami
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.public-subnet-1a.id
  key_name      = aws_key_pair.linux_keypair.key_name


ebs_block_device {
    device_name = "/dev/sdh"
    volume_size = 25
    volume_type = "gp2"
    delete_on_termination = true
}
  tags = {
    Name = "devops_demo_tf"
  }
}


resource "tls_private_key" "linux_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
# We want to save the private key to our machine
# We can then use this key to connect to our Linux VM

resource "local_file" "linuxkey" {
  filename = "linuxkey.pem"
  content  = tls_private_key.linux_key.private_key_pem
}

resource "aws_key_pair" "linux_keypair" {
  key_name   = "linuxkey"
  public_key = tls_private_key.linux_key.public_key_openssh
}
