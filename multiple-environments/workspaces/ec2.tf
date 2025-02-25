resource "aws_security_group" "workspace" {
  name        = "workspace"
  description = "workspace inbound traffic and all outbound traffic"

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
    Name = "workspace"
  }
}

resource "aws_instance" "workspace" {
  ami                    = "ami-09c813fb71547fc4f" # This is our devops-practice AMI ID
  vpc_security_group_ids = [aws_security_group.workspace.id]
  instance_type          = lookup (var.instance_type, terraform.workspace)
  tags = {
    Name    = "workspaces-${terraform.workspace}"
    Purpose = "workspaces"
  }
}