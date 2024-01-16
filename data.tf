#variable "vpc_id" {}

data "aws_vpc" "selected" {
  
}

data "aws_subnet" "example_subnet" {
  vpc_id                  =  data.aws_vpc.selected.id  # Replace with your VPC ID
  availability_zone       = "us-east-1a"   # Replace with your desired availability zone
  # You can add more filters as needed, e.g., "cidr_block", "tag", etc.
}