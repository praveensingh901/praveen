variable "availability_zone" {
   description= "Default availibility zone"
   default = "us-east-1a"

}
variable "key_name" {
    default = "monitoring-key-pair"
  }

  variable "cidr_blocks" {
    type = set(string)
  default = ["31.215.94.128/32", "10.0.1.4/32", "10.0.1.5/32"]
  }

  variable "ami" {
    default = "ami-0005e0cfe09cc9050"
    
  }
  variable "instance_type" {
    default = "t2.micro"
  }