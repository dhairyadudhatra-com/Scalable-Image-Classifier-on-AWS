output "Request_Queue_Name" {
    value = aws_sqs_queue.request_queue.name
}

output "Response_Queue_Name" {
    value = aws_sqs_queue.response_queue.name
}

output "Request_Queue_ARN" {
    value = aws_sqs_queue.request_queue.arn
}

output "Response_Queue_ARN" {
    value = aws_sqs_queue.response_queue.arn
}