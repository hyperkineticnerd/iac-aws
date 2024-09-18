output "subnets" {
    value = [aws_subnet.ocp_subnet_1a.id, aws_subnet.ocp_subnet_1b.id, aws_subnet.ocp_subnet_1c.id]
}

output "vpcs" {
    value = aws_vpc.ocp_new_vpc.id
}

output "azs" {
    value = slice(data.aws_availability_zones.available.names, 0, 3)
}
