locals {  #your split this because in parameter StringList but you want List
  public_subnet_ids =split(",", data.aws_ssm_parameter.public_subnet_ids.value) 
  web_alb_sg_id = data.aws_ssm_parameter.web_alb_sg_id.value
  certificate_arn=data.aws_ssm_parameter.web_alb_certificate_arn.value
}