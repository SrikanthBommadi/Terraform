resource "aws_instance" "srikanth" {
    count = length(var.instances) #stored in variable
  ami                    = "ami-09c813fb71547fc4f" # This is our devops-practice AMI ID
  vpc_security_group_ids = [aws_security_group.srikanth.id]
  instance_type          = "t3.micro"
  tags = merge(
    var.common_tags,
  {
    Name    = var.instances[count.index]
  }
  )
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
    Name = "sriaknth"
  }
}