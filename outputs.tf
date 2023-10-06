output "bucket_name" {
  description = "Bucket name for our static website hosting"
  value = module.home_cartoons_hosting.bucket_name
}

output "s3_website_endpoint" {
  description = "S3 Static Website Hosting endpoint"
  value = module.home_cartoons_hosting.website_endpoint
}

output "domain_name" {
  description = "The CloudFront Distribution Domain Name"
  value = module.home_cartoons_hosting.domain_name
}