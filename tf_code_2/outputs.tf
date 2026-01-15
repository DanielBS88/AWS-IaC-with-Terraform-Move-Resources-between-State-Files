output "policy_arn" {
  value       = aws_iam_policy.this.arn
  description = "ARN of the custom IAM policy"
}
