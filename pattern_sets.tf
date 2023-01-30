resource "aws_wafv2_regex_pattern_set" "whitelist-bots" {
  name        = "${var.project_name}-whitelist-bots"
  description = "${var.project_name}-whitelist-bots"
  scope       = "REGIONAL"

  regular_expression {
    regex_string = "(?i)(cloudfront|googlebot)"
  }

  tags = {
    Environment = var.environment
  }
}

resource "aws_wafv2_regex_pattern_set" "blocked-bots" {
  name        = "${var.project_name}-blocked-bots"
  description = "${var.project_name}-blocked-bots"
  scope       = "REGIONAL"

  regular_expression {
    regex_string = "(?i)(verybadbot)"
  }

  tags = {
    Environment = var.environment
  }
}

resource "aws_wafv2_regex_pattern_set" "whitelist-static-files" {
  name                 = "${var.project_name}-whitelist-static-files"
  description  = "${var.project_name}-whitelist-static-files"
  scope       = "REGIONAL"

  regular_expression {
    regex_string = "(?i)(css|js|jpeg|jpg|gif|ico|swf|json)"
  }

  tags = {
    Environment = var.environment
  }
}