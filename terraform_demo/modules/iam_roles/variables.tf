variable "input_bucket_arn" {
  type = string
  description = "The ARN of the input bucket" 
}

variable "output_bucket_arn" {
  type = string
  description = "The ARN of the output bucket" 
}

variable "request_queue_arn" {
  type = string
  description = "The ARN of the Request queue" 
}

variable "response_queue_arn" {
  type = string
  description = "The ARN of the Response queue" 
}