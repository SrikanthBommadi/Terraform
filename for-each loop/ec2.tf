resource "aws_instance" "srikanth" {
    for_each = var.instances
  ami                    = "ami-09c813fb71547fc4f" # This is our devops-practice AMI ID
  vpc_security_group_ids = [aws_security_group.srikanth.id]
  instance_type          = each.value
  tags = {
    Name    = "srikanth"
    Purpose = "srikanth"
  }
}

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
    Name = "srikanth"
  }
}

output "ec2_info" {
value = aws_instance.srikanth  
}