variable "vpc_region" {
  type = string
  description = "AWS Region for VPC"
  default = "us-east-1"
}

variable "vpc_tag" {
  type = string
  description = "AWS VPC Tag/Name"
  default = "OpenShift-Training"
}

variable "vpc_cidr" {
  type = string
  description = "CIDR for VPC"
  # default = "10.10.0.0/23" # main
  default = "10.10.2.0/23" # training
  # default = "10.10.4.0/23" # staging
  # default = "10.10.6.0/23" # production
}

variable "vpc_subnets_cidrs" {
  type = list(string)
  description = "List of Subnet CIDRs for VPC Creation"
  default = [
    "10.10.2.64/26",
    "10.10.2.128/26",
    "10.10.2.192/26"
  ]
}

variable "aws_service_base" {
  type = string
  description = "Service Name Suffix, in reverse fqdn notation"
  # default = "gov.sgov.sc2s"
  default = "com.amazonaws"
}
