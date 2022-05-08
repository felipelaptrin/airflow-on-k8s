resource "aws_security_group" "this" {
  name        = "vpn-openvpn"
  description = "Security group for the VPN (OpenVPN) instance."
  vpc_id      = data.aws_vpc.this.id

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

resource "aws_instance" "this" {
  ami                         = var.ec2-ami
  instance_type               = var.ec2-instance-type
  key_name                    = var.ec2-key-pair-name
  associate_public_ip_address = true
  security_groups             = [aws_security_group.this.name]


  tags = {
    Name = "VPN - OpenVPN"
  }
}

resource "aws_eip" "this" {
  instance = aws_instance.this.id
  vpc      = true
}
