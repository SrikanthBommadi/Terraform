data "aws_ami" "backend" {
    most_recent      = true
    owners           = ["973714476881"]
    filter {
        name   = "name"
        values = ["RHEL-9-DevOps-Practice"]
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

data "aws_ssm_parameter" "backend_sg_id" {
  name = "/${var.project_name}/${var.environment}/backend_sg_id"
}



data "aws_ssm_parameter" "private_subnet_ids" {
  name = "/${var.project_name}/${var.environment}/private_subnet_ids"
}


data "aws_ssm_parameter" "vpc_id" {
  name = "/${var.project_name}/${var.environment}/vpc_id"
}

data "aws_ssm_parameter" "app_alb_listner_arn" {
  name = "/${var.project_name}/${var.environment}/app_alb_listner_arn"
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