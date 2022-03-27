#Creating an Elastic IP for Nat gateway

resource "aws_eip" "workshop1-nat1" {}
resource "aws_eip" "workshop1-nat2" {}

#Create NAT GW in US-EAST-2A

resource "aws_nat_gateway" "workshop1-nat-gateway-1a" {
    allocation_id = aws_eip.workshop1-nat1.id
    subnet_id = aws_subnet.workshop1-public-1a.id 
    tags = {
        Name = "NAT Gateway - 1A"
        
    }
}

#Create NAT GW in US-EAST-2B

resource "aws_nat_gateway" "workshop1-nat-gateway-1b" {
    allocation_id = aws_eip.workshop1-nat2.id 
    subnet_id = aws_subnet.workshop1-public-1b.id 
    tags = {
        Name = "NAT Gateway - 1B"
        
    }
}