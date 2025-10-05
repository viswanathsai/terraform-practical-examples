output "user_buckets" {
  description = "Map of user buckets created"
  value = {
    for user, bucket in aws_s3_bucket.user_buckets : 
    user => bucket.bucket
  }
}

output "iam_users" {
  description = "Map of IAM users created"
  value = {
    for user, iam_user in aws_iam_user.users :
    user => iam_user.arn
  }
}

output "admin_bucket_created" {
  description = "Whether admin bucket was created"
  value = length(aws_s3_bucket.admin_bucket) > 0
}