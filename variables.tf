variable "vpc_tag" {
  default = "OCP Training"
}

variable "vpc_region" {
    default = "us-east-1"
}

variable "vpc_cidr" {
    # default = "10.10.0.0/23" # main
    default = "10.10.2.0/23" # training
    # default = "10.10.4.0/23" # staging
    # default = "10.10.6.0/23" # production
}

variable "vpc_subnets_cidrs" {
    type = list(string)
    default = [
        "10.10.2.64/26",
        "10.10.2.128/26",
        "10.10.2.192/26"
    ]
}

variable "aws_service_base" {
  # default = "gov.sgov.sc2s"
  default = "com.amazonaws"
}
