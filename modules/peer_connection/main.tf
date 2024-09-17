# Create Peer Connection
resource "aws_vpc_peering_connection" "main_training" {
  # The AWS account ID of the target peer VPC
  peer_owner_id = aws_vpc.main.account.id
  # The ID of the target VPC with which you are creating the VPC Peering Connection
  peer_vpc_id = aws_vpc.main.id
  # The ID of the requester VPC
  vpc_id = aws_vpc.ocp_training.id

  accepter {
    allow_remote_vpc_dns_resolution = true
  }

  requester {
    allow_remote_vpc_dns_resolution = true
  }
}
