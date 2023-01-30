resource "aws_wafv2_rule_group" "Block-Countries" {
  name     = "${var.project_name}-Block-Countries"
  scope    = "REGIONAL"
  capacity = 2

  rule {
    name     = "MGT-Block-Countries"
    priority = 20

    action {
      block {}
    }

    statement {

      geo_match_statement {
        country_codes = var.blocked_countries
        #country_codes = ["RU", "CN"]
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = false
      metric_name                = "${var.project_name}-Block-Countries"
      sampled_requests_enabled   = false
    }
  }

  visibility_config {
    cloudwatch_metrics_enabled = false
    metric_name                = "${var.project_name}-Block-Countries"
    sampled_requests_enabled   = false
  }

  tags = {
    Environment = var.environment
  }
}
