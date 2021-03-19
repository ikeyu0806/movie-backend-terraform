data "aws_route53_zone" "movie-backend" {
  name         = "yikegaya.work"
  private_zone = false
}

resource "aws_route53_record" "movie-backend" {
  name    = data.aws_route53_zone.movie-backend.name
  zone_id = data.aws_route53_zone.movie-backend.id
  type    = "A"

  alias {
    evaluate_target_health = true
    name                   = aws_lb.movie-backend-alb.dns_name
    zone_id                = aws_lb.movie-backend-alb.zone_id
  }
}
