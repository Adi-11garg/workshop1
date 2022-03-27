# Creating  host SG for ssh

resource "aws_security_group" "workshop-sg" {
    vpc_id = aws_vpc.workshop1-vpc.id 
    name = "Host Security Group"
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = [ 
            "0.0.0.0/0"
        ]
    }
    ingress {
        from_port = 22
        to_port = 22
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
        Name = "Workshop SG"
        Terraform = "True"
    }
}

#Create instance host in US-EAST-2A Public subnet

resource "aws_instance" "workshop-1a" {
    ami = "ami-0fb653ca2d3203ac1"
    instance_type = "t2.micro"
    key_name = "aditya"
    associate_public_ip_address = true 
    vpc_security_group_ids = [aws_security_group.workshop-sg.id]
    subnet_id = aws_subnet.workshop1-public-1a.id 
    tags = {
        Name = "Workshop Host - 1A"
        Terraform = "True"
    }
    user_data = file("${path.module}/script.sh")
}

#Create instance host in US-EAST-2B Public subnet

resource "aws_instance" "workshop-1b" {
    ami = "ami-0fb653ca2d3203ac1"
    instance_type = "t2.micro"
    key_name = "aditya"
    associate_public_ip_address = true 
    vpc_security_group_ids = [aws_security_group.workshop-sg.id]
    subnet_id = aws_subnet.workshop1-public-1b.id 
    tags = {
        Name = "Workshop Host - 1B"
        Terraform = "True"
    }
    user_data = file("${path.module}/script.sh")
}
