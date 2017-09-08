# kms
Terraform module for AWS KMS. 
This module configures CMK (customer master kye) in KMS and its aliase. 

## Usage
```terraform
module "cmk" {
  source = "github.com/rampart81/terraform-modules//kms"
  
  name                = "cmk"
  description         = "cmk"
  enable_key_rotation = true
  policy              = <<EOF
{
  "Id": "key-consolepolicy-3",
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "Enable IAM User Permissions",
      "Effect": "Allow",
      "Principal": {
        "AWS": [
          "${var.account_arn}"
        ]
      },
      "Action": "kms:*",
      "Resource": "*"
    },
    {
      "Sid": "Allow access for Key Administrators",
      "Effect": "Allow",
      "Principal": {
        "AWS": [
          "${var.account_arn}"
        ]
      },
      "Action": [
        "kms:Create*",
        "kms:Describe*",
        "kms:Enable*",
        "kms:List*",
        "kms:Put*",
        "kms:Update*",
        "kms:Revoke*",
        "kms:Disable*",
        "kms:Get*",
        "kms:TagResource",
        "kms:UntagResource",
        "kms:ScheduleKeyDeletion",
        "kms:CancelKeyDeletion"
      ],
      "Resource": "*"
    },
    {
      "Sid": "Allow use of the key",
      "Effect": "Allow",
      "Principal": {
        "AWS": [
          "${var.iam_role_arn}"
        ]
      },
      "Action": [
        "kms:Encrypt",
        "kms:Decrypt",
        "kms:ReEncrypt*",
        "kms:GenerateDataKey*",
        "kms:DescribeKey"
      ],
      "Resource": "*"
    },
    {
      "Sid": "Allow attachment of persistent resources",
      "Effect": "Allow",
      "Principal": {
        "AWS": [
          "${var.iam_role_arn}"
        ]
      },
      "Action": [
        "kms:CreateGrant",
        "kms:ListGrants",
        "kms:RevokeGrant"
      ],
      "Resource": "*",
      "Condition": {
        "Bool": {
          "kms:GrantIsForAWSResource": true
        }
      }
    }
  ]
}
EOF
}
```

## Variables
```terraform
variable "description"             {                             } 

# Policy for the key
variable "policy"                  {                             } 

# Set it to true to enable. Should be set to true.
variable "is_enabled"              { default = true              } 

# Set it to true for annual key rotation
variable "enable_key_rotation"     { default = false             } 

variable "deletion_window_in_days" { default = 30                }
variable "name"                    {                             }
```

## Outputs
* `arn` 
* `alias_arn`
* `key_id` 
