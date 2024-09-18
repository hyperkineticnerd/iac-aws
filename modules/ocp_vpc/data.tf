data "aws_vpc" "main" {
    cidr_block = "10.10.0.0/23"
}
data "aws_region" "current" {}
data "aws_availability_zones" "available" {}
