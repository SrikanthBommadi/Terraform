module "mysql_sg" {
    source = "../sg-ec2 vpc"
    common-tags = var.common_tags
    environment = var.environment
    project = var.project_name
    sg_Name = "mysql"
    sg_description = "created for mysql instance"
    vpc_id =data.aws_ssm_parameter.vpc_id.value
}