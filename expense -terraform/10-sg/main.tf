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

##### this is for security ruleesssssssssss   (app alb trafic from bastion)
resource "aws_security_group_rule" "app_alb_bastion" {
  type              = "ingress"    ##ingressssss value###
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  source_security_group_id = module.bastion_sg.sg_id
  security_group_id = module.app_alb_sg.sg_id
}

### asigning the public ip address to bastion to get the internet to the bastion
resource "aws_security_group_rule" "bastion_publicip" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.bastion_sg.sg_id
}
#-------- ports 22, 443, 1194, 943 --> VPN ports
resource "aws_security_group_rule" "vpn_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.vpn_sg.sg_id
}

resource "aws_security_group_rule" "vpn_443" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.vpn_sg.sg_id
}
resource "aws_security_group_rule" "vpn_1194" {
  type              = "ingress"
  from_port         = 1194
  to_port           = 1194
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.vpn_sg.sg_id
}

resource "aws_security_group_rule" "vpn_943" {
  type              = "ingress"
  from_port         = 943
  to_port           = 943
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.vpn_sg.sg_id
}

resource "aws_security_group_rule" "app_alb_vpn" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  security_group_id = module.app_alb_sg.sg_id
  source_security_group_id = module.vpn_sg.sg_id
}
