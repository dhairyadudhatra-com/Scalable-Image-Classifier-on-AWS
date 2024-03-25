# Define SQS Queues
resource "aws_sqs_queue" "request_queue" {
  name                     = var.Request_Queue_Name
  max_message_size         = 6144
  message_retention_seconds = 420
  receive_wait_time_seconds = 5
}

resource "aws_sqs_queue" "response_queue" {
  name                     = var.Response_Queue_Name
  max_message_size         = 6144
  message_retention_seconds = 420
  receive_wait_time_seconds = 5
}
