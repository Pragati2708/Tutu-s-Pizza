resource "aws_iam_role" "sonar_ec2_role" {

  name = "sonarqube-ec2-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}


resource "aws_iam_policy" "sonar_ssm_policy" {

  name = "sonarqube-ssm-policy"

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Action = [
          "ssm:PutParameter"
        ]

        Resource = "*"
      }
    ]
  })
}


resource "aws_iam_role_policy_attachment" "sonar_ssm_attach" {

  role       = aws_iam_role.sonar_ec2_role.name
  policy_arn = aws_iam_policy.sonar_ssm_policy.arn
}


resource "aws_iam_instance_profile" "sonar_profile" {

  name = "sonarqube-instance-profile"

  role = aws_iam_role.sonar_ec2_role.name
}