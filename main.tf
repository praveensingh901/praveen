resource "aws_key_pair" "my_key_pair" {
  key_name   = "my-key-pair"
  public_key = file("id_rsa.pub") # Read the public key from the file
}

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh_security_group"
  description = "Allow SSH access from specific IPs"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["31.215.94.128/32", "10.0.1.4/32", "10.0.1.5/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] # Allow all outbound traffic
  }
}

resource "aws_instance" "my_instance" {
  ami                    = "ami-0005e0cfe09cc9050" # Replace with the desired AMI ID
  instance_type          = "t2.micro"              # Adjust as needed
 # availability_zone      = "us-east-1a"
  subnet_id = data.aws_subnet.example_subnet.id
  key_name               = aws_key_pair.my_key_pair.key_name
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]

  tags = {
    Name = "my-instance"
  }
}

output "ec2-ip" {
    value = aws_instance.my_instance.public_ip
  
}