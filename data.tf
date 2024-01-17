#variable "vpc_id" {}

data "aws_vpc" "selected" {
  
}

data "aws_subnet" "example_subnet" {
  vpc_id                  =  data.aws_vpc.selected.id  # Replace with your VPC ID
  availability_zone       = var.availability_zone   # Replace with your desired availability zone
  # You can add more filters as needed, e.g., "cidr_block", "tag", etc.
}

data "aws_kms_alias" "ebs" {
  name = "alias/ebs-test"
}