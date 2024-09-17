# EC2 VPC Endpoints
resource "aws_vpc_endpoint" "ec2" {
  vpc_id            = var.vpc.id
  service_name      = "${var.aws_service_base}.${var.vpc_region}.ec2"
  vpc_endpoint_type = "Interface"
  subnet_ids = var.subnet_ids
  # security_group_ids = [
  #   aws_security_group.sg1.id,
  # ]

  # private_dns_enabled = true
}

# ELB VPC Endpoints
resource "aws_vpc_endpoint" "elb" {
  vpc_id            = var.vpc.id
  service_name      = "${var.aws_service_base}.${var.vpc_region}.elasticloadbalancing"
  vpc_endpoint_type = "Interface"
  subnet_ids = var.subnet_ids
}

# S3 VPC Endpoints
resource "aws_vpc_endpoint" "s3" {
  vpc_id            = var.vpc.id
  service_name      = "${var.aws_service_base}.${var.vpc_region}.s3"
  subnet_ids = var.subnet_ids
}
