terraform {
  required_version = ">= 0.12"
}

data "aws_region" "current" {}

data "aws_ami" "Ubuntu_AMI" {
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
  most_recent = true
  owners      = ["amazon"]
}

module "s3" {
  source             = "../../modules/s3/"
  input_bucket_name  = var.input_bucket_name
  output_bucket_name = var.output_bucket_name
}

module "sqs" {
  source              = "../../modules/sqs/"
  Request_Queue_Name  = var.Request_Queue_Name
  Response_Queue_Name = var.Response_Queue_Name
}

module "iam_roles" {
  source             = "../../modules/iam_roles/"
  request_queue_arn  = module.sqs.Request_Queue_ARN
  response_queue_arn = module.sqs.Response_Queue_ARN
  input_bucket_arn   = module.s3.input_bucket_arn
  output_bucket_arn  = module.s3.output_bucket_arn
}

module "vpc" {
  source            = "../../modules/vpc/"
  VPC_CIDR_Range    = var.vpc_cidr
  SUBNET_CIDR_Range = var.subnet_cidr
  SUBNET_AZ_Name    = var.subnet_az_name
}

module "security_group" {
  source = "../../modules/security_group"
  vpc_id = module.vpc.vpc_id
}

module "webtier_ec2" {
  source = "../../modules/webtierEC2/"

  web_apptier_sg_id   = module.security_group.TierSG
  webtier_IAM_profile = module.iam_roles.webtier_role
  ami_id              = data.aws_ami.Ubuntu_AMI.id
  subnet_id           = module.vpc.Public_Subnet
}

module "apptier_ec2" {
  source = "../../modules/apptierEC2/"

  apptier_sg_id       = module.security_group.TierSG
  apptier_IAM_profile = module.iam_roles.apptier_role
  ami_id              = data.aws_ami.Ubuntu_AMI.id
  subnet_id           = module.vpc.Public_Subnet
}


