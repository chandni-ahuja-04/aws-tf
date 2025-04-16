# vpc
# Create a VPC
resource "aws_vpc" "myvpc" {
  cidr_block = var.vpc_cidr
}

# subnet_ids
resource "aws_subnet" "pub-sub1" {
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = var.pub_sub_cidr_1

  tags = {
    Name = "pub-sub-1"
  }
}

resource "aws_subnet" "pub-sub2" {
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = var.pub_sub_cidr_2

  tags = {
    Name = "pub-sub-2"
  }
}

resource "aws_subnet" "private-sub1" {
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = var.pvt_sub_cidr_1

  tags = {
    Name = "private-sub-1"
  }
}

resource "aws_subnet" "private-sub2" {
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = var.pvt_sub_cidr_2

  tags = {
    Name = "private-sub-2"
  }
}

# IGW
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.myvpc.id

  tags = {
    Name = "IGW"
  }
}

# EIP
resource "aws_eip" "myeip" {
  tags = {
    Name = "my-eip"
  } 
}

# NAT
resource "aws_nat_gateway" "nat-gateway" {
  allocation_id = aws_eip.myeip.id
  subnet_id     = aws_subnet.pub-sub1.id

  tags = {
    Name = "NAT"
  }

}

# public-route
resource "aws_route_table" "public-route" {
  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block = var.route_cidr
    gateway_id = aws_internet_gateway.igw.id
  }

  
  tags = {
    Name = "public-route"
  }
}

# private-route
resource "aws_route_table" "private-route" {
  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block = var.route_cidr
    gateway_id = aws_nat_gateway.nat-gateway.id
  }

  
  tags = {
    Name = "private-route"
  }
}

# subnet-associate
resource "aws_route_table_association" "public-a" {
  subnet_id      = aws_subnet.pub-sub1.id
  route_table_id = aws_route_table.public-route.id
}

resource "aws_route_table_association" "public-b" {
  subnet_id      = aws_subnet.pub-sub2.id
  route_table_id = aws_route_table.public-route.id
}

resource "aws_route_table_association" "private-a" {
  subnet_id      = aws_subnet.private-sub1.id
  route_table_id = aws_route_table.private-route.id
}

resource "aws_route_table_association" "private-b" {
  subnet_id      = aws_subnet.private-sub2.id
  route_table_id = aws_route_table.private-route.id
}