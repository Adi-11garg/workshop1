resource "aws_internet_gateway" "workshop1-igw" {
    vpc_id = aws_vpc.workshop1-vpc.id
    tags = {
        Name = "Workshop Internet Gateway"

    }
}