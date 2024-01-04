
# Create VPC
resource "aws_vpc" "my_vpc" {
    cidr_block = "10.0.0.0/16"
}

# Create public subnets
resource "aws_subnet" "public_subnet_1" {
    vpc_id                  = aws_vpc.my_vpc.id
    cidr_block              = "10.0.1.0/24"
    availability_zone       = "us-east-1a"
    map_public_ip_on_launch = true
}

resource "aws_subnet" "public_subnet_2" {
    vpc_id                  = aws_vpc.my_vpc.id
    cidr_block              = "10.0.2.0/24"
    availability_zone       = "us-east-1b"
    map_public_ip_on_launch = true
}

# Create internet gateway
resource "aws_internet_gateway" "my_igw" {
    vpc_id = aws_vpc.my_vpc.id
}


# Create a route table
resource "aws_route_table" "my_route_table" {
    vpc_id = aws_vpc.my_vpc.id
}

# Associate the route table with the subnet
resource "aws_route_table_association" "my_route_table_association" {
    subnet_id      = aws_subnet.private_subnet.id
    route_table_id = aws_route_table.my_route_table.id
}

// Create VPC
resource "aws_vpc" "my_vpc" {
    cidr_block = "10.0.0.0/16"
}

// Create public subnets
resource "aws_subnet" "public_subnet_1" {
    vpc_id                  = aws_vpc.my_vpc.id
    cidr_block              = "10.0.1.0/24"
    availability_zone       = "us-east-1a"
    map_public_ip_on_launch = true
}

resource "aws_subnet" "public_subnet_2" {
    vpc_id                  = aws_vpc.my_vpc.id
    cidr_block              = "10.0.2.0/24"
    availability_zone       = "us-east-1b"
    map_public_ip_on_launch = true
}
