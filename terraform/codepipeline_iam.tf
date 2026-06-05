resource "aws_iam_role" "codepipeline_role" {

  name = "AWSCodePipelineServiceRole-ap-south-1-tutus-pizza-pipeline"

  path = "/service-role/"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Principal = {
          Service = "codepipeline.amazonaws.com"
        }

        Action = "sts:AssumeRole"
      }
    ]
  })
}