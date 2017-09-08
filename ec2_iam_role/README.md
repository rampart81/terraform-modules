# ec2_iam_role
Terraform module for AWS IAM Role for EC2.

## Usage
```terraform
module "frontend_ec2_role" {
  source = "github.com/rampart81/terraform-modules//ec2_iam_role"
 
  name            = "app_iam_role"
  iam_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": ["s3:ListBucket"],
      "Resource": [
        "${var.s3_arn}"
      ]
    },
    {
      "Effect": "Allow",
      "Action": [
        "s3:PutObject",
        "s3:GetObject",
        "s3:DeleteObject"
      ],
      "Resource": [
        "${var.s3_arn}/*"
      ]
    }
  ]
}
EOF
}
```

## Variables
```terraform
# IAM Role policy to attach
variable "iam_role_policy" { }

variable "name"            { }
```

## Outputs
* `iam_arn` 
* `iam_create_date` 
* `iam_unique_id` 
* `iam_name` 
* `iam_description` 
* `iam_profile_id` 
