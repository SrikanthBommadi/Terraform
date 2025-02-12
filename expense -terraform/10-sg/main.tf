module "mysql_sg" {
    source = "git::https://github.com/SrikanthBommadi/Terraform//sg-ec2 vpc?ref=main"
    common-tags = var.common_tags
    environment = var.environment
    project = var.project_name
    sg_Name = "mysql"
    sg_description = "created for mysql instance"
    vpc_id =data.aws_ssm_parameter.vpc_id.value
}

module "backend_sg" {
    source = "git::https://github.com/SrikanthBommadi/Terraform//sg-ec2 vpc?ref=main"
    common-tags = var.common_tags
    environment = var.environment
    project = var.project_name
    sg_Name = "backend "
    sg_description = "created for backend instance"
    vpc_id =data.aws_ssm_parameter.vpc_id.value
}


module "frontend_sg" {
    source = "git::https://github.com/SrikanthBommadi/Terraform//sg-ec2 vpc?ref=main"
    common-tags = var.common_tags
    environment = var.environment
    project = var.project_name
    sg_Name = "frontend "
    sg_description = "created for frontend instance"
    vpc_id =data.aws_ssm_parameter.vpc_id.value
}


module "bastion_sg" {     ####its for jumping value or jump host
    source = "git::https://github.com/SrikanthBommadi/Terraform//sg-ec2 vpc?ref=main"
    common-tags = var.common_tags
    environment = var.environment
    project = var.project_name
    sg_Name = "bastion "
    sg_description = "created for bastion instance"
    vpc_id =data.aws_ssm_parameter.vpc_id.value
}

module "app_alb_sg" {
    source = "git::https://github.com/SrikanthBommadi/Terraform//sg-ec2 vpc?ref=main"
    common-tags = var.common_tags
    environment = var.environment
    project = var.project_name
    sg_Name = "app-alb "
    sg_description = "created for app alb instance"
    vpc_id =data.aws_ssm_parameter.vpc_id.value
}



# ports 22, 443, 1194, 943 --> VPN ports
module "vpn_sg" {
    source = "git::https://github.com/SrikanthBommadi/Terraform//sg-ec2 vpc?ref=main"
    common-tags = var.common_tags
    environment = var.environment
    project = var.project_name
    sg_Name = "vpn "
    sg_description = "created for vpn instance for project dev"
    vpc_id =data.aws_ssm_parameter.vpc_id.value
}