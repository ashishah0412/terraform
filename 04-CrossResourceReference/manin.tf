
# Local variables
locals {
  instance_type = "t2.micro"
  total_instances = 1
}

# Resource definition
resource "aws_instance" "example" {
  ami           = "ami-072ec8f4ea4a6f2cf"
  instance_type = local.instance_type
  security_groups = [aws_security_group.EC2SG.name]
}

resource "aws_eip" "EC2Elastic" {
  instance = aws_instance.example.id 
  domain   = "vpc"
}

resource "aws_security_group" "EC2SG" {
  name        = "allow_ssh"
  description = "Allow ssh inbound traffic"
  
  ingress {
    description      = "TLS from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]    
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_EC2EIP"
  }
  
}

resource "aws_network_interface_sg_attachment" "sg_attachment" {
  security_group_id    = "${aws_security_group.EC2SG.id}"
  network_interface_id = "${aws_instance.example.primary_network_interface_id}"
}



