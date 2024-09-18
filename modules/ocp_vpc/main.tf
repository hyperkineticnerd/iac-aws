# Create a VPC
resource "aws_vpc" "ocp_new_vpc" {
  cidr_block = var.vpc_cidr
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = var.vpc_tag
  }
}

resource "aws_subnet" "ocp_subnet_1a" {  
  vpc_id     = aws_vpc.ocp_new_vpc.id
  availability_zone = data.aws_availability_zones.available.names[0]
  cidr_block = var.vpc_subnets_cidrs[0]
}

resource "aws_subnet" "ocp_subnet_1b" {  
  vpc_id     = aws_vpc.ocp_new_vpc.id
  availability_zone = data.aws_availability_zones.available.names[1]
  cidr_block = var.vpc_subnets_cidrs[1]
}

resource "aws_subnet" "ocp_subnet_1c" {  
  vpc_id     = aws_vpc.ocp_new_vpc.id
  availability_zone = data.aws_availability_zones.available.names[2]
  cidr_block = var.vpc_subnets_cidrs[2]
}

# EC2 VPC Endpoints
resource "aws_vpc_endpoint" "ec2" {
  vpc_id            = aws_vpc.ocp_new_vpc.id
  service_name      = "${var.aws_service_base}.${data.aws_region.current.name}.ec2"
  vpc_endpoint_type = "Interface"
  subnet_ids = [aws_subnet.ocp_subnet_1a.id, aws_subnet.ocp_subnet_1b.id, aws_subnet.ocp_subnet_1c.id]
  private_dns_enabled = true
}

# ELB VPC Endpoints
resource "aws_vpc_endpoint" "elb" {
  vpc_id            = aws_vpc.ocp_new_vpc.id
  service_name      = "${var.aws_service_base}.${data.aws_region.current.name}.elasticloadbalancing"
  vpc_endpoint_type = "Interface"
  subnet_ids = [aws_subnet.ocp_subnet_1a.id, aws_subnet.ocp_subnet_1b.id, aws_subnet.ocp_subnet_1c.id]
  private_dns_enabled = true
}

# S3 VPC Endpoints
resource "aws_vpc_endpoint" "s3" {
  vpc_id            = aws_vpc.ocp_new_vpc.id
  service_name      = "${var.aws_service_base}.${data.aws_region.current.name}.s3"
  vpc_endpoint_type = "Gateway"
  # subnet_ids = [aws_subnet.ocp_subnet_1a.id, aws_subnet.ocp_subnet_1b.id, aws_subnet.ocp_subnet_1c.id]
  # private_dns_enabled = true
}

# Create Peer Connection
resource "aws_vpc_peering_connection" "main_training" {
  vpc_id = aws_vpc.ocp_new_vpc.id
  peer_owner_id = data.aws_vpc.main.owner_id
  peer_vpc_id = data.aws_vpc.main.id
  auto_accept   = true

  accepter {
    allow_remote_vpc_dns_resolution = true
  }

  requester {
    allow_remote_vpc_dns_resolution = true
  }
}

resource "aws_security_group" "ocp_bastion" {
  name        = "OCP Bastion"
  description = "Allow traffic to/from Bastion Host"
  vpc_id      = aws_vpc.ocp_new_vpc.id

  tags = {
    Name = "OCP Bastion"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_all_ipv4_from_main" {
  security_group_id = aws_security_group.ocp_bastion.id
  cidr_ipv4         = data.aws_vpc.main.cidr_block
  ip_protocol       = "-1"
}

resource "aws_vpc_security_group_ingress_rule" "allow_all_ipv4_from_vpc" {
  security_group_id = aws_security_group.ocp_bastion.id
  cidr_ipv4         = aws_vpc.ocp_new_vpc.cidr_block
  ip_protocol       = "-1"
}

resource "aws_vpc_security_group_egress_rule" "allow_all_ipv4_to_all" {
  security_group_id = aws_security_group.ocp_bastion.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}
