data "aws_ssm_parameter" "vpc_id" {
  name = "/${var.environment}/${var.project_name}/vpc_id"
}
