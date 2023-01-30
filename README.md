# tf-aws-waf
Terraform aws-waf (Web Application Firewall).

How to use it:

```
module "waf" {
  source          = "git@github.com:open-servus/terraform-waf-module.git?ref=main"
  project_name    = var.project_name
  environment     = var.environment
}
```