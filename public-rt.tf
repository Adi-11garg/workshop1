#Public route table for public subnets
resource "aws_route_table" "workshop1-public" {
    vpc_id = aws_vpc.workshop1-vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.workshop1-igw.id 
    }
    tags = {
        Name = "Workshop Public Route Table"
        Terraform = "True"
    }
}

#Attach the public route table to public subnets
resource "aws_route_table_association" "workshop1-public-1a-association" {
    subnet_id = aws_subnet.workshop1-public-1a.id 
    route_table_id = aws_route_table.workshop1-public.id 
}

resource "aws_route_table_association" "workshop1-public-1b-association" {
    subnet_id = aws_subnet.workshop1-public-1b.id 
    route_table_id = aws_route_table.workshop1-public.id
}