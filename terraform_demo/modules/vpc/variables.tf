variable "VPC_CIDR_Range" {
    type = string
    description = "CIDR Range for VPC"
}

variable "SUBNET_CIDR_Range" {
    type = string
    description = "CIDR Range for Subnet"
}

variable "SUBNET_AZ_Name" {
    type = string
    description = "AZ Name for Subnet"
    default = "us-west-2a"
    validation {
        condition = substr(var.SUBNET_AZ_Name, 0, 9) == "us-west-2"
        error_message = "AZ Name must be in the us-west-2 region."
    }
}