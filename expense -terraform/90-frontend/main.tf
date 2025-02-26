resource "aws_instance" "frontend" {
  ami                    =  data.aws_ami.frontend.id                 # This is our devops-practice AMI ID
  vpc_security_group_ids = [data.aws_ssm_parameter.frontend_sg_id.value]
  instance_type          = "t3.micro"
  subnet_id = local.public_subnet_id
  tags = merge(
    var.common_tags,
    {
      Name = "${var.project_name}-${var.environment}-public"
    }
  )
}


# The primary use-case for the null resource is as a do-nothing container
# for arbitrary actions taken by a provisioner.

resource "null_resource" "frontend" {
  # it wont create any thing but i will use to copy the files of instance using provisioning
  triggers = {  # when the instance or server 
    instance_id = aws_instance.frontend.id 
      }

  # Bootstrap script can run on any instance of the cluster
  # So we just choose the first in this case
  connection {
    host = aws_instance.frontend.public_ip
    type     = "ssh"
    user     = "ec2-user"
    password = "DevOps321"
      }

 provisioner "file" {
    source      = "frontend.sh"
    destination = "/tmp/frontend.sh"
 
  }

 provisioner "remote-exec" {
    inline = [ 
    "chmod +x /tmp/frontend.sh",
      "sudo sh /tmp/frontend.sh ${var.environment}"
    ]
    
  }
}
### her we stoping the instance that created above####
resource "aws_ec2_instance_state" "frontend" {
  instance_id = aws_instance.frontend.id
  state       = "stopped"
  depends_on = [null_resource.frontend]
}

####after stoping the instance we have to capture the snapshot of the ami #### 
resource "aws_ami_from_instance" "frontend" {
  name               = local.resource_name
  source_instance_id = aws_instance.frontend.id
  depends_on = [aws_ec2_instance_state.frontend]  ##take after stop only##
}



resource "null_resource" "frontend_delete" {

  triggers = {
    instance_id = aws_instance.frontend.id
  }

provisioner"local-exec"{
  command = "aws ec2 terminate-instances --instance-ids ${aws_instance.frontend.id}"
}
depends_on = [ aws_ami_from_instance.frontend ]
}

resource "aws_lb_target_group" "frontend" {
  name     = local.resource_name
  port     = 80
  protocol = "HTTP"
  vpc_id   = local.vpc_id
 deregistration_delay = 60
  health_check {
    healthy_threshold   = 2
    interval            = 20
    protocol            = "HTTP"
    timeout             = 5
    matcher             = "200-299"
    path                = "/"
    unhealthy_threshold = 2
    port              = 80
  }
}



resource "aws_launch_template" "frontend" {
  name = local.resource_name
image_id = aws_ami_from_instance.frontend.id
instance_initiated_shutdown_behavior = "terminate"
update_default_version = true
  # instance_market_options {
  #   market_type = "spot"
  # }
  instance_type = "t3.micro"

  # kernel_id = "test"
  # key_name = "test"

  vpc_security_group_ids = [local.frontend_sg_id]

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = local.resource_name
    }
  }

}
############################################33

resource "aws_autoscaling_group" "frontend" {
  name                      = local.resource_name
  max_size                  = 3
  min_size                  = 2
  health_check_grace_period = 60
  health_check_type         = "ELB"
  desired_capacity          = 2
 target_group_arns = [aws_lb_target_group.frontend.arn]
  launch_template {
    id      = aws_launch_template.frontend.id
    version = "$Latest"
  }
  vpc_zone_identifier       = local.public_subnet_ids

instance_refresh {
    strategy = "Rolling"
    preferences {
      min_healthy_percentage = 50
    }
    triggers = ["launch_template"]
  }

  tag {
    key                 = "Name"
    value               = local.resource_name
    propagate_at_launch = true
  }

  timeouts {
    delete = "10m"
  }
  tag {
    key                 = "project"
    value               = "terraform"
    propagate_at_launch = false
  }

  tag {
    key                 = "environment"
    value               = "dev"
    propagate_at_launch = false
  }
}

#######################
# listener ruleesssssssssss
resource "aws_lb_listener_rule" "frontend" {
  listener_arn = data.aws_ssm_parameter.web_alb_listner_arn.value
  priority     = 9

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.frontend.arn
  }

  condition {
    host_header {
      values = ["frontend.web-${var.project_name}.${var.environment}"]
    }
  }
}



#####
resource "aws_autoscaling_policy" "bat" {
  name                   = "${local.resource_name}-frontend"
  policy_type            = "TargetTrackingScaling"
  autoscaling_group_name = aws_autoscaling_group.frontend.name
  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }

    target_value = 70.0
  }
}