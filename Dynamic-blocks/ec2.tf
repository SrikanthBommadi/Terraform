resource "aws_instance" "srikanth" {
  ami                    = "ami-09c813fb71547fc4f" # This is our devops-practice AMI ID
  vpc_security_group_ids = [aws_security_group.srikanth.id]
  instance_type          = "t3.micro"
  tags = {
    Name    = "srikanth"
    Purpose = "srikanth"
  }
}

resource "aws_security_group" "srikanth" {
  name        = "srikanth"
  description = "srikanth inbound traffic and all outbound traffic"

dynamic "ingress" {
  for_each = var.ingress_ports
  content {
    from_port = ingress.value["from_port"]
    to_port = ingress.value["to_port"]
    protocol = ingress.value["protocol"]
    cidr_blocks = ingress.value["cidr_blocks"]
  }
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