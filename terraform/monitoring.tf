# SNS Topic for Alerts

resource "aws_sns_topic" "ecs_alerts" {

  name = "tutus-pizza-alerts"

}


# Email Subscription

resource "aws_sns_topic_subscription" "email_alert" {

  topic_arn = aws_sns_topic.ecs_alerts.arn

  protocol = "email"

  endpoint = "gethealthywithbooster@gmail.com"

}



# ECS CPU Alarm

resource "aws_cloudwatch_metric_alarm" "ecs_cpu_high" {

  alarm_name = "tutus-pizza-high-cpu"

  comparison_operator = "GreaterThanThreshold"

  evaluation_periods = 2

  metric_name = "CPUUtilization"

  namespace = "AWS/ECS"

  period = 60

  statistic = "Average"

  threshold = 80


  dimensions = {

    ClusterName = aws_ecs_cluster.tutus_pizza_cluster.name

    ServiceName = aws_ecs_service.tutus_pizza_service.name

  }


  alarm_actions = [

    aws_sns_topic.ecs_alerts.arn

  ]

}



# ECS Memory Alarm

resource "aws_cloudwatch_metric_alarm" "ecs_memory_high" {

  alarm_name = "tutus-pizza-high-memory"

  comparison_operator = "GreaterThanThreshold"

  evaluation_periods = 2

  metric_name = "MemoryUtilization"

  namespace = "AWS/ECS"

  period = 60

  statistic = "Average"

  threshold = 80


  dimensions = {

    ClusterName = aws_ecs_cluster.tutus_pizza_cluster.name

    ServiceName = aws_ecs_service.tutus_pizza_service.name

  }


  alarm_actions = [

    aws_sns_topic.ecs_alerts.arn

  ]

}