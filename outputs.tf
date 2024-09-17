output "subnets" {
    value = module.subnets.subnet_ids
}

output "vpcs" {
    value = aws_vpc.ocp_new_vpc.id
}

output "azs" {
    value = slice(module.subnets.azs, 0, 3)
}
