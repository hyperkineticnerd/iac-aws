output "subnets" {
  description = "List of Subnets for AZs"
  value = [aws_subnet.ocp_subnet_1a.id, aws_subnet.ocp_subnet_1b.id, aws_subnet.ocp_subnet_1c.id]
}

output "vpcs" {
  description = "New VPC ID"
  value = aws_vpc.ocp_new_vpc.id
}

output "azs" {
  description = "First 3 AZs for a given AWS Region"
  value = slice(data.aws_availability_zones.available.names, 0, 3)
}
