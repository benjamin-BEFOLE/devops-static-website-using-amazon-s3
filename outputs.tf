output "website_endpoint" {
  value = "http://${aws_s3_bucket_website_configuration.website_configuration.website_endpoint}"
}
