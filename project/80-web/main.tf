module "alb" {
  source = "terraform-aws-modules/alb/aws"  #this is the copy of the sorce 
  internal = false                         # because its public we have to give true for refering from the net

#our project detail below
name = "${var.project_name}-${var.environment}-web-alb"
vpc_id = data.aws_ssm_parameter.vpc_id.value
subnets = local.public_subnet_ids
create_security_group = false   # if true means u have to take from the source path only
enable_deletion_protection = false
security_groups = [local.web_alb_sg_id]
tags =merge(
    var.common_tags,
    {
        Name ="${var.project_name}-${var.environment}-web-alb"
    }
)
}

resource "aws_lb_listener" "https" {
  load_balancer_arn = module.alb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = local.certificate_arn

  default_action {
    type             = "fixed-response"

    fixed_response {
      content_type = "text/html"   # its only content after text 
      message_body = "<h1>hello,this is backend serever"  
      status_code  = "200"
    }
  }
}


resource "aws_route53_record" "web_alb" {
  zone_id = var.zone_id
  name    = "sri-${var.environment}.${var.domain_name}"
  type    = "A"
##ALB DNS NAME AND ZONE INFO
  alias {  #alias mean it will take the automatically from the aws account 
    name                   = module.alb.dns_name
    zone_id                = module.alb.zone_id
    evaluate_target_health = false
  }
}