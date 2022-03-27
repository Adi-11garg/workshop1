#ALB Security Group
resource "aws_security_group" "workshop_alb_sg" {
    vpc_id = aws_vpc.workshop1-vpc.id 
    name = "ALB Security Group"
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = [
            "0.0.0.0/0"
        ]
    }
    ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = [ 
            "0.0.0.0/0"
        ]
    }
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = [ 
            "0.0.0.0/0"
        ]
    }
    tags = {
        Name = "Workshop ALB SG"
        Terraform = "True"
    }
}

#Create Application Load Balancer

resource "aws_lb" "workshop_alb" {
    name = "workshop-app-load-balancer"
    internal = false 
    load_balancer_type = "application"
    security_groups = [aws_security_group.workshop_alb_sg.id]
    subnets = [
        aws_subnet.workshop1-public-1a.id,
        aws_subnet.workshop1-public-1b.id,
    ]
    enable_deletion_protection = false 
    tags = {
        Name = "Workshop ALB"
        Terraform = "True"
    }
}