resource "aws_vpc" "public_vpc" {
  cidr_block = var.VPC_CIDR_Range
  tags = {
    Name = "Scalable_Image_Classifier_VPC"
  }
  enable_dns_support = true
  enable_dns_hostnames = true
}

resource "aws_internet_gateway" "Scalable_Image_Classifier_igw" {
tags = {
    Name = "Scalable_Image_Classifier_igw"
  }
  vpc_id = aws_vpc.public_vpc.id
}

resource "aws_route_table" "Scalable_Image_Classifier_rt" {
  tags = {
    Name = "Scalable_Image_Classifier_RT"
  }
  vpc_id = aws_vpc.public_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.Scalable_Image_Classifier_igw.id
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.public_vpc.id
  cidr_block = var.SUBNET_CIDR_Range   # Adjust this CIDR block for your subnet
  availability_zone = var.SUBNET_AZ_Name  # Adjust the availability zone as needed
  tags = {
    Name = "Scalable_Image_Classifier_Public_Subnet"
  }

  map_public_ip_on_launch = true  # This enables auto-assigning public IP addresses to instances launched in this subnet
}

resource "aws_route_table_association" "public_subnet_association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.Scalable_Image_Classifier_rt.id
}

