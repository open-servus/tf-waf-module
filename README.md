# tf-aws-waf
Terraform aws-waf (Web Application Firewall).

How to use it:

```
module "waf" {
  source            = "git::https://github.com/open-servus/tf-waf-module.git?ref=main"
  project_name      = "Openservus"
  environment       = "prod"
  whitelist_ipv4    = ["1.2.3.4/32", "5.6.7.8/32"]
  whitelist_ipv6    = ["2001:db8:abcd:0012::0/80"]
  blocked_ipv4      = ["3.2.3.4/32", "4.6.7.8/32"]
  blocked_ipv6      = ["2001:db8:abcd:0012::0/64"]
  blocked_countries = ["TV", "TN"]
  alb_arn           = "arn:xxx"
}
```