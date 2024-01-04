
# Create Public Subnet 1
# terraform aws create subnet
resource "aws_subnet" "public-subnet-1a" {
    vpc_id = aws_vpc.my_vpc_devops.id
    cidr_block = "11.0.1.0/24"
    availability_zone = "ca-central-1a"
    map_public_ip_on_launch = true
    tags = {
      Name = "public-subnet-devops_demo_tf"
    }
}


# Create Private Subnet 1
# terraform aws create subnet
resource "aws_subnet" "private-subnet-1" {
  vpc_id                  = aws_vpc.my_vpc_devops.id
  cidr_block              = "11.0.2.0/24"
  map_public_ip_on_launch = false
  availability_zone = "ca-central-1a"

  tags = {
    Name = "private-subnet-devops_demo_tf"
  }
}