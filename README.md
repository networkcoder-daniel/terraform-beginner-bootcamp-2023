# Terraform Beginner Bootcamp 2023

![Terraform Bootcamp Diagram](https://github.com/networkcoder-daniel/terraform-beginner-bootcamp-2023/assets/12187128/6c18361c-70d3-42ef-9103-40c572bc1f50)

## Journals
- [Week 0 Journal](journal/week0.md)
- [Week 1 Journal](journal/week1.md)

## Extras
- [Github Markdown TOC Generator](https://ecotrust-canada.github.io/markdown-toc/)

## Fix using Terraform Refresh

```sh
terraform apply -refresh-only -auto-approve
```

## Terraform Modules

### Terraform Module Structure

It is recommend to place modules in a `modules` directory when locally developing modules but you can name it whatever you like.

### Passing Input Variables

We can pass input variables to our module. The module has to declare the terraform variables in its own variables.tf

```tf
module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
  user_uuid = var.user_uuid
  bucket_name = var.bucket_name
}
```

### Modules Sources

Using the source we can import the module from various places, eg:

- Locally
- Github
- Terraform Registry

module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
}

[Modules Sources](https://developer.hashicorp.com/terraform/language/modules/sources)