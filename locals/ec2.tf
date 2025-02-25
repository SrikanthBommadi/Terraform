resource "aws_security_group" "srikanth" {
  name        = "srikanth"
  description = "srikanth inbound traffic and all outbound traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sriaknth"
  }
}

resource "aws_instance" "srikanth" {
  ami                    = local.ami_id # This is our devops-practice AMI ID
  vpc_security_group_ids = [aws_security_group.srikanth.id]
  instance_type          = local.instance_type
  tags = {
    Name    = "srikanth"
    Purpose = "srikanth"
  }
}