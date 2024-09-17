output "region" {
    value = data.aws_region.current.name
}
output "azs" {
    value = data.aws_availability_zones.available.names
}

output "subnet_ids" {
  value = [aws_subnet.ocp_subnet_1a.id, aws_subnet.ocp_subnet_1b.id, aws_subnet.ocp_subnet_1c.id]
}
