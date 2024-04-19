# vpc configuration
resource "aws_vpc" "vpc" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"

  tags = {
    Name = "${var.project_name}-vpc"
  }
}

# Internet-gateway configuration

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    name = "internet_gateway"
  }

}

# create route table and add public route

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id

  # since this is exactly the route AWS will create, the route will be adopted
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }

  tags = {
    Name = "public_route_table"
  }

}

# use data source to get all avalablility zones in region
data "aws_availability_zones" "available_zones" {}


# create public web-subnet
resource "aws_subnet" "web-subnet" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.web-subnet
  availability_zone       = data.aws_availability_zones.available_zones.names[0]
  map_public_ip_on_launch = true

  tags = {
    Name = "web-subnet"
  }
}

# Associate public subnet to "public route table"
resource "aws_route_table_association" "public_route_table_association" {
  subnet_id      = aws_subnet.web-subnet.id
  route_table_id = aws_route_table.public_route_table.id
}

# create private app-subnet 
resource "aws_subnet" "app-subnet" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.app-subnet
  availability_zone       = data.aws_availability_zones.available_zones.names[1]
  map_public_ip_on_launch = false

  tags = {
    Name = "app-subnet"
  }
}

# create public subnet for nat-gateway
resource "aws_subnet" "nat-subnet" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.nat-subnet
  availability_zone = data.aws_availability_zones.available_zones.names[2]
  tags = {
    Name = "Public Subnet for NAT Gateway"
  }
}

# Creating EIP
resource "aws_eip" "eip" {
  domain = "vpc"
}

# create nat-gateway for private subnet
resource "aws_nat_gateway" "nat-gateway" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.nat-subnet.id
}
