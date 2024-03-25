output "webtier_role" {
    value = aws_iam_role.webtier_role.arn
}

output "apptier_role" {
    value = aws_iam_role.apptier_role.arn
}