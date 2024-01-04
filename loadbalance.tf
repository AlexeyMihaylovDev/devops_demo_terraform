# Create security group for the load balancer
resource "aws_security_group" "elb_sg" {
    name        = "elb_sg"
    description = "Allow inbound traffic"
    vpc_id      = aws_vpc.my_vpc.id

    ingress {
        from_port   = 80
        to_port     = 80
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

# Create load balancer
resource "aws_elb" "my_elb" {
    name               = "my_elb"
    subnets            = [aws_subnet.public_subnet_1.id, aws_subnet.public_subnet_2.id]
    security_groups    = [aws_security_group.elb_sg.id]

    listener {
        instance_port     = 80
        instance_protocol = "http"
        lb_port           = 80
        lb_protocol       = "http"
    }

    # Add new listener for TCP port 80
    listener {
        instance_port     = 80
        instance_protocol = "tcp"
        lb_port           = 80
        lb_protocol       = "tcp"
    }

    health_check {
        healthy_threshold   = 2
        unhealthy_threshold = 2
        timeout             = 3
        target              = "HTTP:80/"
        interval            = 30
    }
}

# Create EC2 instances
resource "aws_instance" "my_instance_1" {
    ami           = "ami-0c94855ba95c574c8"
    instance_type = "t2.micro"
    subnet_id     = aws_subnet.public_subnet_1.id

    tags = {
        Name = "Instance 1"
    }
}

resource "aws_instance" "my_instance_2" {
    ami           = "ami-0c94855ba95c574c8"
    instance_type = "t2.micro"
    subnet_id     = aws_subnet.public_subnet_2.id

    tags = {
        Name = "Instance 2"
    }
}

# Attach EC2 instances to the load balancer
resource "aws_elb_attachment" "elb_attach_1" {
    elb      = aws_elb.my_elb.id
    instance = aws_instance.my_instance_1.id
}

resource "aws_elb_attachment" "elb_attach_2" {
    elb      = aws_elb.my_elb.id
    instance = aws_instance.my_instance_2.id
}
