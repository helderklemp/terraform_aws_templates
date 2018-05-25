# terraform_aws_templates
A group of Terraform templates to deploy a AWS Stack

The project aim is to provide a solid example of Terraform on AWS stack.

## Modules
* vpc: 2 tier vpoc ( public and private accross SYdney regions with 3 AZs)
* s3: list of buckets used in the stack
* ecs: ecs configuration

## Terraform Modules
Each folder insine modules is a independent terraform module and can be executed indepently as follow:

```golang
    terraform init
```
```golang
    terraform plan
```
```golang
    terraform apply
```

## Using modules
Inside the main.tf file on the root folder we can use each module as follow:

```golang
    module "s3" {
        source = "../module/s3/"
        branch = "feature"
    }
```

Therefore our aws stack can be modularised into small pieces of code, leavereging this function compositions feature provided by Terraform
