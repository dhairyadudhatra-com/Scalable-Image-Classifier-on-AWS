resource "aws_cloudwatch_metric_alarm" "scale_up_alarm"{
    alarm_name = "app_tier_scale_up_alarm"
    comparison_operator = "GreaterThanThreshold"
    evaluation_periods = "1"
    statistic = "Sum"
    namespace = "AWS/SQS"
    metric_name = "ApproximateNumberOfMessagesVisible"
    period = "60"
    threshold = "5"
    alarm_description = "This metric monitors SQS for messages"
    dimensions = {
        QueueName = var.Request_Queue_Name
    }
    alarm_actions = [var.upscale_policy_arn]
    actions_enabled = true

}

resource "aws_cloudwatch_metric_alarm" "scale_down_alarm"{
    alarm_name = "app_tier_scale_down_alarm"
    comparison_operator = "LessThanThreshold"
    evaluation_periods = "1"
    statistic = "Sum"
    namespace = "AWS/SQS"
    metric_name = "ApproximateNumberOfMessagesVisible"
    period = "60"
    threshold = "5"
    alarm_description = "This metric monitors SQS for messages"
    dimensions = {
        QueueName = var.Request_Queue_Name
    }
    actions_enabled = true
    alarm_actions = [var.downscale_policy_arn]

}