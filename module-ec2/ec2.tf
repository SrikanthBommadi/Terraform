resource "aws_instance" "module" {
  ami                    = var.ami_id
  vpc_security_group_ids = [var.sg_id]
#   instance_type = local.instance_type # its tottaly based on the refernce where u want to assign the location
  instance_type          = var.instance_type
  tags = var.tags
}