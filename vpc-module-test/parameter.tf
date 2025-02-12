# this is for vpc id parameter
resource "aws_ssm_parameter" "vpc_id" {
  name  = "/${var.environment}/${var.project_name}/vpc_id"
  type  = "String"
  value = module.vpc.vpc_id
}