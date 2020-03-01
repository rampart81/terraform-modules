# terraform-modules

<aside class="warning">
For the older version 0.11, refer to `feature/0.11`.
For example:

```terraform
module vpc {
    source = "github.com/rampart81/terraform-modules//vpc?ref=0.11"
	...
}
```
</aside>

Terraform Modules for AWS 

* [alb](./alb): Application Load Balancer
* [default_vpc](./default_vpc): Default VPC (not new VPC)
* [ec2_iam_role](./ec2_iam_role): EC2 IAM Role
* [kms](./kms): Key Management Service
* [vpc](./vpc): VPC
* [vpc_peering](./vpc_peering): VPC Peering
* [rds](./rds): AWS RDS
