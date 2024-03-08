resource "aws_cloudwatch_metric_alarm" "alarm_up" {
  alarm_name = "alarm_up"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods = 2
  metric_name = "CPUUtilization"
  namespace = "AWS/EC2"
  period = "60"
  statistic = "Average"
  threshold = 80
  alarm_description = "monitors CPU utilization"
  alarm_actions = [ aws_autoscaling_policy.challenge2_asp_up.arn]
}

resource "aws_cloudwatch_metric_alarm" "alarm_down" {
  alarm_name = "alarm_down"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods = 2
  metric_name = "CPUUtilization"
  namespace = "AWS/EC2"
  period = "60"
  statistic = "Average"
  threshold = 30
  alarm_description = "monitors CPU utilization"
  alarm_actions = [ aws_autoscaling_policy.challenge2_asp_down.arn]
}