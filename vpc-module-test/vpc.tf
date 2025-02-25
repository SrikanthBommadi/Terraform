module "vpc"{
source = "../vpc-module"
project_name = var.project_name
environment = var.environment
vpc_cidr = var.vpc_cidr
common_tags = var.common_tags
vpc_tags = var.vpc_tags
public_subnet_cidrs = var.public_subnet_cidrs
private_subnet_cidrs = var.private_subnet_cidrs
db_subnet_cidrs = var.db_subnet_cidrs
is_peering_required = true
}