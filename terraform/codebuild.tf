# CodeBuild Project
resource "aws_codebuild_project" "app_build" {
  name          = "cap-1-build"
  description   = "Build project for simple web app"
  service_role  = aws_iam_role.codebuild_role.arn
  artifacts {
    type = "CODEPIPELINE"
  }
  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:5.0"
    type                        = "LINUX_CONTAINER"
    environment_variables = [
      {
        name  = "ENV"
        value = "dev"
      }
    ]
    privileged_mode = true
  }
  source {
    type      = "CODEPIPELINE"
    buildspec = "buildspec.yml"
  }
}
