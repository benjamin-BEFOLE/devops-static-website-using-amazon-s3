# Create bucket
resource "aws_s3_bucket" "website_bucket" {
  bucket        = var.website_bucket_name
  force_destroy = true
}

# Enable Public Access
resource "aws_s3_bucket_public_access_block" "website_public_access_block" {
  bucket = aws_s3_bucket.website_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# Update bucket policy to allow anyone to get the objects of bucket
resource "aws_s3_bucket_policy" "website_bucket_policy" {
  bucket = aws_s3_bucket.website_bucket.id
  policy = data.template_file.name.rendered
}

# Add website pages to bucket
resource "aws_s3_object" "s3_object_index" {
  key          = "index.html"
  bucket       = aws_s3_bucket.website_bucket.id
  source       = "src/index.html"
  content_type = "text/html"
}

resource "aws_s3_object" "s3_object_error" {
  key          = "error.html"
  bucket       = aws_s3_bucket.website_bucket.id
  source       = "src/error.html"
  content_type = "text/html"
}

# Configure bucket to host website pages
resource "aws_s3_bucket_website_configuration" "website_configuration" {
  bucket = aws_s3_bucket.website_bucket.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }

  depends_on = [
    aws_s3_object.s3_object_index,
    aws_s3_object.s3_object_error
  ]
}
