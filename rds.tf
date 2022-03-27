#Create RDS SG

resource "aws_security_group" "workshop_db_sg" {
    name = "Workshop RDS Security Group"
    vpc_id = aws_vpc.workshop1-vpc.id 
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 3306
        to_port = 3306
        protocol = "tcp"
        security_groups = [ 
            aws_security_group.workshop_asg_sg.id 
        ]
    }
    tags = {
        Name = "RDS Security Group"
        Terraform = "True"
    }
}

#Create Database Subnet Group

resource "aws_db_subnet_group" "workshop-db-subnet" {
    name = "workshop-database-subnet-group"
    subnet_ids = [
        aws_subnet.workshop1-private-1a.id,
        aws_subnet.workshop1-private-1b.id 
    ]
    tags = {
        Name = "DB Subnet Group"
        Terraform = "True"
    }
}

#Database Instance

resource "aws_db_instance" "workshop-db" {
    allocated_storage = "10"
    storage_type = "gp2"
    engine = "mysql"
    engine_version = "5.7"
    multi_az = "true"
    instance_class = "db.t2.micro"
    name = "mydb"
    username = "admin"
    password = var.db-master-password 
    identifier = "workshop-database"
    skip_final_snapshot = "true"
    backup_retention_period = "7"
    port = "3306"
    storage_encrypted = "false"
    db_subnet_group_name = aws_db_subnet_group.workshop-db-subnet.name 
    vpc_security_group_ids = [aws_security_group.workshop_db_sg.id]
    tags = {
        Name = "Workshop Database"
        Terraform = "True"
    }
}