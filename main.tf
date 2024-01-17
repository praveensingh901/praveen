resource "aws_key_pair" "my_key_pair" {
  key_name   = var.key_name
  public_key = file("id_rsa.pub") # Read the public key from the file
}

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh_security_group"
  description = "Allow SSH access from specific IPs"
  vpc_id = data.aws_vpc.selected.id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.cidr_blocks
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] # Allow all outbound traffic
  }
}



resource "aws_instance" "my_instance" {
  ami                    = var.ami # Replace with the desired AMI ID
  instance_type          = var.instance_type             # Adjust as needed
  subnet_id = data.aws_subnet.example_subnet.id
  key_name               = aws_key_pair.my_key_pair.key_name
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]
  root_block_device {
    encrypted = true
    volume_type = "gp3"
    kms_key_id = data.aws_kms_alias.ebs.id
  }
  ebs_block_device {
    device_name = "/dev/sdf"
    encrypted = true
    volume_size = "150"
    volume_type = "gp3"
    kms_key_id = data.aws_kms_alias.ebs.id
  }
  tags = {
    Name = "my-instance"
  }
}

output "ec2-ip" {
    value = aws_instance.my_instance.private_ip
  
}