resource "aws_wafv2_ip_set" "Blocked-IPv4" {
  name               = "${var.project_name}-Blocked-IPv4"
  description        = "${var.project_name}-Blocked-IPv4"
  scope              = "REGIONAL"
  ip_address_version = "IPV4"
  addresses          = var.blocked_ipv4
  #addresses          = ["1.2.3.4/32", "5.6.7.8/32"]

  tags = {
    Environment = var.environment
  }
}

resource "aws_wafv2_ip_set" "Blocked-IPv6" {
  name               = "${var.project_name}-Blocked-IPv6"
  description        = "${var.project_name}-Blocked-IPv6"
  scope              = "REGIONAL"
  ip_address_version = "IPV6"
  addresses          = var.blocked_ipv6

  tags = {
    Environment = var.environment
  }
}

resource "aws_wafv2_ip_set" "Whitelisted-IPv4" {
  name               = "${var.project_name}-Whitelisted-IPv4"
  description        = "Whitelisted-IPv4"
  scope              = "REGIONAL"
  ip_address_version = "IPV4"
  addresses          = var.whitelist_ipv4

  tags = {
    Environment = var.environment
  }
}

resource "aws_wafv2_ip_set" "Whitelisted-IPv6" {
  name               = "${var.project_name}-Whitelisted-IPv6"
  description        = "Whitelisted-IPv6"
  scope              = "REGIONAL"
  ip_address_version = "IPV6"
  addresses          = var.whitelist_ipv6

  tags = {
    Environment = var.environment
  }
}