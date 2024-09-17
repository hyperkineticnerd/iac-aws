# Create a VPC
# resource "aws_vpc" "main" {
#   cidr_block = "10.10.0.0/23"
# }

resource "aws_vpc" "ocp_training" {
  cidr_block = "10.10.2.0/23"
  enable_dns_support = true
  enable_dns_hostnames = true
}

# resource "aws_vpc" "ocp_staging" {
#   cidr_block = "10.10.4.0/23"
# }

# resource "aws_vpc" "ocp_prod" {
#   cidr_block = "10.10.6.0/23"
# }

module "subnets" {
    source = "./modules/subnets"
    vpc = aws_vpc.ocp_training
    vpc_region = "us-east-1"
}

module "endpoints" {
    source = "./modules/endpoints"
    vpc = aws_vpc.ocp_training
    vpc_region = "us-east-1"
    subnet_ids = module.subnets.subnet_ids
}
