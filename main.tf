# Create a VPC
resource "aws_vpc" "ocp_new_vpc" {
  cidr_block = var.vpc_cidr
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "ocp_subnet_1a" {  
  vpc_id     = aws_vpc.ocp_new_vpc
  availability_zone = data.aws_availability_zones.available.names[0]
  cidr_block = var.vpc_subnets_cidrs[0]
}

resource "aws_subnet" "ocp_subnet_1b" {  
  vpc_id     = aws_vpc.ocp_new_vpc
  availability_zone = data.aws_availability_zones.available.names[1]
  cidr_block = var.vpc_subnets_cidrs[1]
}

resource "aws_subnet" "ocp_subnet_1c" {  
  vpc_id     = aws_vpc.ocp_new_vpc
  availability_zone = data.aws_availability_zones.available.names[2]
  cidr_block = var.vpc_subnets_cidrs[2]
}

# EC2 VPC Endpoints
resource "aws_vpc_endpoint" "ec2" {
  vpc_id            = var.vpc.id
  service_name      = "${var.aws_service_base}.${data.aws_region.current.name}.ec2"
  vpc_endpoint_type = "Interface"
  subnet_ids = [aws_subnet.ocp_subnet_1a.id, aws_subnet.ocp_subnet_1b.id, aws_subnet.ocp_subnet_1c.id]
  private_dns_enabled = true
}

# ELB VPC Endpoints
resource "aws_vpc_endpoint" "elb" {
  vpc_id            = var.vpc.id
  service_name      = "${var.aws_service_base}.${data.aws_region.current.name}.elasticloadbalancing"
  vpc_endpoint_type = "Interface"
  subnet_ids = [aws_subnet.ocp_subnet_1a.id, aws_subnet.ocp_subnet_1b.id, aws_subnet.ocp_subnet_1c.id]
  private_dns_enabled = true
}

# S3 VPC Endpoints
resource "aws_vpc_endpoint" "s3" {
  vpc_id            = var.vpc.id
  service_name      = "${var.aws_service_base}.${data.aws_region.current.name}.s3"
  subnet_ids = [aws_subnet.ocp_subnet_1a.id, aws_subnet.ocp_subnet_1b.id, aws_subnet.ocp_subnet_1c.id]
  private_dns_enabled = true
}


# Create Peer Connection
# resource "aws_vpc_peering_connection" "main_training" {
#   vpc_id = aws_vpc.ocp_new_vpc.id
#   peer_owner_id = data.aws_vpc.main.account.id
#   peer_vpc_id = data.aws_vpc.main.id

#   accepter {
#     allow_remote_vpc_dns_resolution = true
#   }

#   requester {
#     allow_remote_vpc_dns_resolution = true
#   }
# }
