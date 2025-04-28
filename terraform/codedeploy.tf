# Create CodeDeploy Application
resource "aws_codedeploy_app" "web_app" {
  name = "cap-1-codedeploy-app"
  compute_platform = "Server"
}

# Create CodeDeploy Deployment Group
resource "aws_codedeploy_deployment_group" "web_app_group" {
  app_name              = aws_codedeploy_app.web_app.name
  deployment_group_name = "cap-1-codedeploy-group"
  service_role_arn      = aws_iam_role.codedeploy_role.arn

  deployment_style {
    deployment_type = "IN_PLACE"
    deployment_option = "WITHOUT_TRAFFIC_CONTROL"
  }

  ec2_tag_set {
    ec2_tag_filter {
      key   = "Name"
      type  = "KEY_AND_VALUE"
      value = "web-instance"
    }
  }

  auto_rollback_configuration {
    enabled = true
    events  = ["DEPLOYMENT_FAILURE"]
  }
}
