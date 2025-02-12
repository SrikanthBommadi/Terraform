module "mysql_sg" {
    source = "../../sg-ec2 vpc"
    common-tags = var.common_tags
    environment = var.environment
    project = var.project_name
    sg_Name = "mysql"
    sg_description = "created for mysql instance"
    vpc_id =data.aws_ssm_parameter.vpc_id.value
}

module "backend_sg" {
    source = "../../sg-ec2 vpc"
    common-tags = var.common_tags
    environment = var.environment
    project = var.project_name
    sg_Name = "backend "
    sg_description = "created for backend instance"
    vpc_id =data.aws_ssm_parameter.vpc_id.value
}


module "frontend_sg" {
    source = "../../sg-ec2 vpc"
    common-tags = var.common_tags
    environment = var.environment
    project = var.project_name
    sg_Name = "frontend "
    sg_description = "created for frontend instance"
    vpc_id =data.aws_ssm_parameter.vpc_id.value
}


module "bastion_sg" {     ####its for jumping value or jump host
    source = "../../sg-ec2 vpc"
    common-tags = var.common_tags
    environment = var.environment
    project = var.project_name
    sg_Name = "bastion "
    sg_description = "created for bastion instance"
    vpc_id =data.aws_ssm_parameter.vpc_id.value
}
