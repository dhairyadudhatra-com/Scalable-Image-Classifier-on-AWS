output "webtier_role" {
    value = aws_iam_instance_profile.webtier_iam_profile.name
}

output "apptier_role" {
    value = aws_iam_instance_profile.apptier_iam_profile.name
}