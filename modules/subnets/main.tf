resource "aws_subnet" "ocp_subnet_1a" {  
  vpc_id     = var.vpc.id
  availability_zone = data.aws_availability_zones.available.names[0]
  cidr_block = "10.10.2.64/26"
}

resource "aws_subnet" "ocp_subnet_1b" {  
  vpc_id     = var.vpc.id
  availability_zone = data.aws_availability_zones.available.names[1]
  cidr_block = "10.10.2.128/26"
}

resource "aws_subnet" "ocp_subnet_1c" {  
  vpc_id     = var.vpc.id
  availability_zone = data.aws_availability_zones.available.names[2]
  cidr_block = "10.10.2.192/26"
}
