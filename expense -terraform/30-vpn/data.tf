data "aws_ami" "openvpn" {
    most_recent      = true
    owners           = ["679593333241"]
    filter {
        name   = "name"
        values = ["OpenVPN Access Server Community Image-fe8020db-*"]
    }

    filter {
        name   = "root-device-type"
        values = ["ebs"]
    }

    filter {
        name   = "virtualization-type"
        values = ["hvm"]
    }
}

data "aws_ssm_parameter" "vpn_sg_id" {
  name = "/${var.project_name}/${var.environment}/vpn_sg_id"
}



data "aws_ssm_parameter" "public_subnet_ids" {
  name = "/${var.project_name}/${var.environment}/public_subnet_ids"
}
























#################down path can be deleted if u want but this file was taken reference from the data source ######
# data "aws_vpc" "default" {
#   default = true
# }

# output  "ami_id" {
#   value       = data.aws_ami.srikanth.id
# }

# output "default_vpc_id" {
#     value = data.aws_vpc.default.id
# }