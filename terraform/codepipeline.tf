resource "aws_codepipeline" "tutus_pipeline" {

  name          = "tutus-pizza-pipeline"
  pipeline_type = "V2"

  execution_mode = "QUEUED"


  role_arn = aws_iam_role.codepipeline_role.arn


  artifact_store {
    location = "codepipeline-ap-south-1-8e5c35c45d60-4b23-93fe-413a2f7fd037"
    type     = "S3"
  }


  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeStarSourceConnection"
      version          = "1"
      output_artifacts = ["SourceArtifact"]

      configuration = {

        ConnectionArn = "arn:aws:codeconnections:ap-south-1:779846808506:connection/0275ee9f-b237-492f-b1aa-dfc89679813e"

        FullRepositoryId = "Pragati2708/Tutu-s-Pizza"

        BranchName = "main"

        DetectChanges = "true"
      }
    }
  }


  stage {
    name = "Build"

    action {
      name     = "Build"
      category = "Build"
      owner    = "AWS"
      provider = "CodeBuild"
      version  = "1"

      input_artifacts = ["SourceArtifact"]

      output_artifacts = ["BuildArtifact"]


      configuration = {

        ProjectName = aws_codebuild_project.tutus_build.name

      }
    }
  }

  stage {

    name = "Test"

    action {

      name = "Test"

      category = "Test"
      owner    = "AWS"
      provider = "CodeBuild"
      version  = "1"

      input_artifacts = [
        "SourceArtifact"
      ]

      configuration = {

        ProjectName = "tutus-pizza-build"

      }
    }
  }

  stage {
    name = "Deploy"

    action {
      name     = "Deploy"
      category = "Deploy"
      owner    = "AWS"
      provider = "CodeDeployToECS"
      version  = "1"


      input_artifacts = [
        "BuildArtifact"
      ]


      configuration = {

        ApplicationName = aws_codedeploy_app.tutus_pizza_app.name

        DeploymentGroupName = aws_codedeploy_deployment_group.tutus_pizza_dg.deployment_group_name


        # yesterday's fixes

        AppSpecTemplateArtifact = "BuildArtifact"

        AppSpecTemplatePath = "appspec.yml"


        TaskDefinitionTemplateArtifact = "BuildArtifact"

        TaskDefinitionTemplatePath = "taskdef.json"


        Image1ArtifactName = "BuildArtifact"

        Image1ContainerName = "IMAGE1_NAME"
      }
    }
  }
}