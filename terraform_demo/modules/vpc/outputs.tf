output "vpc_id" {
  value = aws_vpc.public_vpc.id
}

output "Public_Subnet" {
  value = aws_subnet.public_subnet.id
}