#output "policy_arn" {
#  value       = aws_iam_policy.this.arn
#  description = "ARN of the custom IAM policy"
#}
output "policy_arn" {
  description = "ARN of the IAM policy"
  value       = try(aws_iam_policy.this[0].arn, null)
}
