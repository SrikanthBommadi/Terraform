locals {  #your join this because in parameter StringList but you want List
  private_subnet_ids =split(",", data.aws_ssm_parameter.private_subnet_ids.value) 
  app_alb_sg_id = data.aws_ssm_parameter.app_alb_sg_id.value
}