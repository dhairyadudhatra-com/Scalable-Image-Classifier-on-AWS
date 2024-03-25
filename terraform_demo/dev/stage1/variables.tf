variable "input_bucket_name" {
  type        = string
  description = "Name of the input bucket"
}

variable "output_bucket_name" {
  type        = string
  description = "Name of the output bucket"
}

variable "Request_Queue_Name" {
  type        = string
  description = "Name of the Request Queue"
}

variable "Response_Queue_Name" {
  type        = string
  description = "Name of the Response Queue"
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR Range for VPC"
}

variable "subnet_cidr" {
  type        = string
  description = "CIDR Range for Subnet"
}

variable "subnet_az_name" {
  type        = string
  description = "AZ Name for Subnet"
}