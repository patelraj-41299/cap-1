resource "aws_codedeploy_app" "deployment_app" {
  name = "deployment-app"
  compute_platform = "Server"
}

resource "aws_codedeploy_deployment_group" "deployment_group" {
  app_name               = aws_codedeploy_app.deployment_app.name
  deployment_group_name  = "deployment-group"
  service_role_arn       = aws_iam_role.codedeploy_service_role.arn

  autoscaling_groups = [aws_autoscaling_group.app_asg.name]

  deployment_style {
    deployment_option = "WITH_TRAFFIC_CONTROL"
    deployment_type   = "BLUE_GREEN"
  }
}
