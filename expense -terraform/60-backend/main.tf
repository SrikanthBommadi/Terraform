resource "aws_instance" "backend" {
  ami                    =  data.aws_ami.backend.id                 # This is our devops-practice AMI ID
  vpc_security_group_ids = [data.aws_ssm_parameter.backend_sg_id.value]
  instance_type          = "t3.micro"
  subnet_id = local.private_subnet_id
  tags = merge(
    var.common_tags,
    {
      Name = "${var.project_name}-${var.environment}-backend"
    }
  )
}


# The primary use-case for the null resource is as a do-nothing container
# for arbitrary actions taken by a provisioner.

resource "null_resource" "backend" {
  # Changes to any instance of the cluster requires re-provisioning
  triggers = {  # when the instance or server 
    instance_id = aws_instance.backend.id 
      }

  # Bootstrap script can run on any instance of the cluster
  # So we just choose the first in this case
  connection {
    host = aws_instance.backend.private_ip
    type     = "ssh"
    user     = "ec2-user"
    password = "DevOps321"
      }

 provisioner "file" {
    source      = "backend.sh"
    destination = "/tmp/backend.sh"
  }

  provisioner "remote-exec" {
    inline = [ 
    "chmod +x /tmp/backend.sh",
      "sudo sh /tmp/backend.sh ${var.environment}"
    ]
    
  }
}