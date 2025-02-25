resource "aws_cloudfront_distribution" "terraform" {
  origin {
    domain_name              ="sri-${var.environment}.${var.domain_name}" ##sri-developer.srikanthaws.fun
    origin_id                = "sri-${var.environment}.${var.domain_name}"
     custom_origin_config  {
        http_port              = 80
        https_port             = 443
        origin_protocol_policy = "https-only"
        origin_ssl_protocols   = ["TLSv1.2"]
    }
  }

  enabled             = true


  aliases = ["sri-cdn.${var.domain_name}"]

  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "sri-${var.environment}.${var.domain_name}"

    viewer_protocol_policy = "https-only"
    cache_policy_id = data.aws_cloudfront_cache_policy.noCache.id
  }

  # Cache behavior with precedence 0
  ordered_cache_behavior {
    path_pattern     = "/images/*"
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD", "OPTIONS"]
    target_origin_id = "sri-${var.environment}.${var.domain_name}"

     cache_policy_id = data.aws_cloudfront_cache_policy.noCache.id
    viewer_protocol_policy = "https-only"
  }

  # Cache behavior with precedence 1
  ordered_cache_behavior {
    path_pattern     = "/static/*"
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "sri-${var.environment}.${var.domain_name}"
    cache_policy_id = data.aws_cloudfront_cache_policy.noCache.id
    viewer_protocol_policy = "https-only"

  }
 restrictions {
    geo_restriction {
      restriction_type = "whitelist"
       locations        = ["US", "IN","DE"]
    }
  }

  tags = merge(
var.common_tags,
{
    Name ="${var.project_name}.${var.environment}"
}
  ) 

  viewer_certificate {
     acm_certificate_arn = local.https_certificate_arn
    ssl_support_method = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }
}


resource "aws_route53_record" "cdn" {
  zone_id = var.zone_id
  name    = "sri-cdn.${var.domain_name}"
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.terraform.domain_name
    zone_id                = aws_cloudfront_distribution.terraform.hosted_zone_id
    evaluate_target_health = false
  }
  allow_overwrite = true
}