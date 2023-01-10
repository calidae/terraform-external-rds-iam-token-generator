# RDS IAM role authentication token generator

This module replicates the aws-cli `aws rds generate-db-auth-token` command but is used to avoid copying the same script to every
terraform project.

This is a workaround while terraform aws provider doesn't implement a way to get these tokens, look at this [issue](https://github.com/hashicorp/terraform-provider-aws/issues/28762).

## Example usages


```
module "rds_iam_token_generator" {
  source = "calidae/rds-iam-token-generator"
  db_instances = {
    production = {
        hostname = "foo.bar.production.com"
        port     = 5432
        username = "foo"
    }
  }
}

resource "postgresql_role" "foo" {
  name  = "foo"
  ...
  roles = ["rds_iam", ...]
}

resource "aws_db_instance" "production" {
    db_name = "foo.bar"
    ...
    iam_database_authentication_enabled = true
}

provider "postgresql" {
  host      = "foo.bar.production.com"
  port      = 5432
  database  = "postgres"
  username  = "foo"
  password  = module.rds_iam_token_generator.tokens["production"]
  sslmode   = "require"
  superuser = false
}
```
