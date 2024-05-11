data "template_file" "name" {
  template = file("templates/website_bucket_policy_document.tpl")
  vars = {
    bucket_arn = aws_s3_bucket.website_bucket.arn
  }
}
