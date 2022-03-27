#Creating first Private route table

resource "aws_route_table" "workshop1_private_route_table_1a" {
    vpc_id = aws_vpc.workshop1-vpc.id 
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_nat_gateway.workshop1-nat-gateway-1a.id 
    }
    tags = {
        Name = "Workshop Private Route Table - 1A"
        Terraform = "True"
    }
}

#Attaching with first private subnet 

resource "aws_route_table_association" "workshop1-1a" {
    subnet_id = aws_subnet.workshop1-private-1a.id 
    route_table_id = aws_route_table.workshop1_private_route_table_1a.id 
}

#Creating second Private route table

resource "aws_route_table" "workshop1_private_route_table_1b" {
    vpc_id = aws_vpc.workshop1-vpc.id 
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_nat_gateway.workshop1-nat-gateway-1b.id 
    }
    tags = {
        Name = "Workshop Private Route Table - 1B"
        Terraform = "True"
    }
}

#Attaching with second private subnet 

resource "aws_route_table_association" "workshop1-1b" {
    subnet_id = aws_subnet.workshop1-private-1b.id 
    route_table_id = aws_route_table.workshop1_private_route_table_1b.id 
}