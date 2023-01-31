resource "aws_wafv2_web_acl" "main" {
  name  = "${var.project_name}-${var.environment}"
  scope = "REGIONAL"

  default_action {
    allow {}
  }

  ###RULE=================================

  rule {
    name     = "${var.project_name}-Block-IPs"
    priority = 20

    action {
      block {}
    }

    statement {
      or_statement {
        statement {
          ip_set_reference_statement {
            arn = aws_wafv2_ip_set.Blocked-IPv4.arn
          }
        }
        statement {
          ip_set_reference_statement {
            arn = aws_wafv2_ip_set.Blocked-IPv6.arn
          }
        }
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "${var.project_name}-Block-IPs"
      sampled_requests_enabled   = true
    }
  }

  ###RULE=================================

  rule {
    name     = "${var.project_name}-Whitelist-Bots"
    priority = 21

    action {
      allow {}
    }

    statement {
      regex_pattern_set_reference_statement {
        field_to_match {
          single_header {
            name = "user-agent"
          }
        }
        arn = aws_wafv2_regex_pattern_set.whitelist-bots.arn

        text_transformation {
          type     = "NONE"
          priority = 0
        }

      }

    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "${var.project_name}-Whitelist-Bots"
      sampled_requests_enabled   = true
    }
  }

  ###RULE=================================

  rule {
    name     = "${var.project_name}-Whitelist-IPs"
    priority = 22

    action {
      allow {}
    }

    statement {
      or_statement {
        statement {
          ip_set_reference_statement {
            arn = aws_wafv2_ip_set.Whitelisted-IPv4.arn
          }
        }
        statement {
          ip_set_reference_statement {
            arn = aws_wafv2_ip_set.Whitelisted-IPv6.arn
          }
        }
      }

    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "${var.project_name}-Whitelist-IPs"
      sampled_requests_enabled   = true
    }
  }

  ###RULE=================================

  rule {
    name     = "${var.project_name}-Block-Bots"
    priority = 23

    action {
      block {}
    }

    statement {
      regex_pattern_set_reference_statement {
        field_to_match {
          single_header {
            name = "user-agent"
          }
        }
        arn = aws_wafv2_regex_pattern_set.blocked-bots.arn

        text_transformation {
          type     = "NONE"
          priority = 0
        }

      }

    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "${var.project_name}-Block-Bots"
      sampled_requests_enabled   = true
    }
  }

  ###RULE=================================

  rule {
    name     = "${var.project_name}-Block-Countries"
    priority = 24

    override_action {
      none {}
    }

    statement {
      rule_group_reference_statement {
        arn = aws_wafv2_rule_group.Block-Countries.arn
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "${var.project_name}-Block-Countries"
      sampled_requests_enabled   = true
    }
  }

  ###RULE=================================

  rule {
    name     = "AWSManagedRulesLinuxRuleSet"
    priority = 25
    override_action {
      none {}
    }
    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesLinuxRuleSet"
        vendor_name = "AWS"
      }
    }
    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "AWSManagedRulesLinuxRuleSet"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "AWSManagedRulesCommonRuleSet"
    priority = 26
    override_action {
      none {}
    }
    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesCommonRuleSet"
        vendor_name = "AWS"
        rule_action_override {
          name = "GenericRFI_QUERYARGUMENTS"
          action_to_use {
            count {}
          }
        }
        rule_action_override {
          name = "SizeRestrictions_BODY"
          action_to_use {
            count {}
          }
        }
      }
    }
    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "AWSManagedRulesCommonRuleSet"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "AWSManagedRulesUnixRuleSet"
    priority = 27
    override_action {
      none {}
    }
    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesUnixRuleSet"
        vendor_name = "AWS"
      }
    }
    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "AWSManagedRulesUnixRuleSet"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "AWSManagedRulesPHPRuleSet"
    priority = 28
    override_action {
      none {}
    }
    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesPHPRuleSet"
        vendor_name = "AWS"
      }
    }
    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "AWSManagedRulesPHPRuleSet"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "AWSManagedRulesSQLiRuleSet"
    priority = 29
    override_action {
      none {}
    }
    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesSQLiRuleSet"
        vendor_name = "AWS"
      }
    }
    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "AWSManagedRulesSQLiRuleSet"
      sampled_requests_enabled   = true
    }
  }

  ### You exceeded the capacity limit for a rule group or web ACL.
  # rule {
  #   name     = "AWSManagedRulesKnownBadInputsRuleSet"
  #   priority = 30
  #   override_action {
  #     none {}
  #   }
  #   statement {
  #     managed_rule_group_statement {
  #       name        = "AWSManagedRulesKnownBadInputsRuleSet"
  #       vendor_name = "AWS"
  #     }
  #   }
  #   visibility_config {
  #     cloudwatch_metrics_enabled = true
  #     metric_name                = "AWSManagedRulesKnownBadInputsRuleSet"
  #     sampled_requests_enabled   = true
  #   }
  # }

  # rule {
  #   name     = "${var.project_name}-Rate-Limit"
  #   priority = 31

  #   override_action {
  #     block {}
  #   }

  #   statement {
  #     rate_based_statement {
  #       limit              = 677
  #       aggregate_key_type = "IP"
  #     }
  #   }

  #   visibility_config {
  #     cloudwatch_metrics_enabled = true
  #     metric_name                = "${var.project_name}-Rate-Limit"
  #     sampled_requests_enabled   = true
  #   }
  # }
  ### You exceeded the capacity limit for a rule group or web ACL.

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "${var.project_name}-${var.environment}"
    sampled_requests_enabled   = true
  }

  tags = {
    Name        = "${var.project_name}-${var.environment}"
    Environment = var.environment
  }
}

resource "aws_wafv2_web_acl_association" "alb" {
  resource_arn = var.alb_arn
  web_acl_arn  = aws_wafv2_web_acl.main.arn
}