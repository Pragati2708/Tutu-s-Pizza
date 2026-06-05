resource "aws_codebuild_project" "tutus_build" {

  name         = "tutus-pizza-build"
  description  = "Build project for Tutus Pizza DevSecOps pipeline"
  service_role = aws_iam_role.codebuild_role.arn

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {

    compute_type = "BUILD_GENERAL1_SMALL"
    image        = "aws/codebuild/standard:8.0"
    type         = "LINUX_CONTAINER"

    privileged_mode = true


    environment_variable {
      name  = "SONAR_HOST_URL"
      value = "/tutus-pizza/SONAR_HOST_URL"
      type  = "PARAMETER_STORE"
    }

    environment_variable {
      name  = "SONAR_TOKEN"
      value = "/tutus-pizza/SONAR_TOKEN"
      type  = "PARAMETER_STORE"
    }
  }


  source {
    type      = "CODEPIPELINE"
    buildspec = "buildspec.yml"
  }


  logs_config {

    cloudwatch_logs {
      status = "ENABLED"
    }

  }
}