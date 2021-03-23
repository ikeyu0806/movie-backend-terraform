# このterraformでacm発行できるが現状手動で設定
resource "aws_acm_certificate" "movie-backend-acm" {
  domain_name               = aws_route53_record.movie-backend.name
  subject_alternative_names = []
  validation_method         = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}
