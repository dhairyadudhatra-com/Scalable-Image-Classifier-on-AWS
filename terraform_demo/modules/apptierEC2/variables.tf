variable "ami_id" {
    type = string
    description = "AMI ID filtered by Region"
}

variable "apptier_sg_id" {
    type = string
    description = "Web App Tier Security Group ID"
}

variable "apptier_IAM_profile" {
    type = string
    description =  "Web Tier IAM Instance Profile"
}

variable "subnet_id" {
    type = string
    description = "Subnet ID"
}


