output "input_bucket_name" {
  value = module.s3.input_bucket_name
}

output "output_bucket_name" {
  value = module.s3.output_bucket_name
}

output "Request_Queue_Name" {
  value = module.sqs.Request_Queue_Name
}

output "Response_Queue_Name" {
  value = module.sqs.Response_Queue_Name
}

output "Webtier_IAMRole" {
  value = module.iam_roles.webtier_role
}

output "Apptier_IAMRole" {
  value = module.iam_roles.apptier_role
}

output "Public_VPC" {
  value = module.vpc.vpc_id
}

output "TierSG"{
  value = module.security_group.TierSG
}