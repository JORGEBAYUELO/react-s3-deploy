output "s3_bucket_name" {
  value = aws_s3_bucket.static_site.id
}

output "s3_website_endpoint" {
  value = aws_s3_bucket_website_configuration.static_site.website_endpoint
}

output "cloudfront_domain_name" {
  value = aws_cloudfront_distribution.cdn.domain_name
}
