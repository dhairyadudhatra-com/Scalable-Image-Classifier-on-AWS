output "upscale_policy_arn" {
    value = aws_autoscaling_policy.upscale_policy.arn
}

output "downscale_policy_arn" {
    value = aws_autoscaling_policy.downscale_policy.arn
}