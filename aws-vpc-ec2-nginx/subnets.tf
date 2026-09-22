resource "aws_subnet" "public-subnet-ngx" {
  vpc_id     = aws_vpc.vpc-ngx.id
  cidr_block = "10.0.2.0/24"
  tags = {
    Name = "public-subnet.ngx"
  }
}

resource "aws_subnet" "private-subnet-ngx" {
  vpc_id     = aws_vpc.vpc-ngx.id
  cidr_block = "10.0.3.0/24"
  tags = {
    Name = "private-subnet.ngx"
  }
}

resource "aws_internet_gateway" "igw-ngx" {
  vpc_id = aws_vpc.vpc-ngx.id
  tags = {
    Name = "igw-ngx"
  }
}

resource "aws_route_table" "rt-ngx" {
  vpc_id = aws_vpc.vpc-ngx.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw-ngx.id
  }
  tags = {
    Name = "rt-ngx"
  }
}

resource "aws_route_table_association" "public-sub" {
  route_table_id = aws_route_table.rt-ngx.id
  subnet_id      = aws_subnet.public-subnet-ngx.id

}
