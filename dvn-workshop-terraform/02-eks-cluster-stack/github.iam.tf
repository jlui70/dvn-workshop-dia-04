resource "aws_iam_role" "github" {
  name = "DevopsprojectGitHubActionRole"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = ["sts:AssumeRoleWithWebIdentity"]
        Effect = "Allow"
        Principal = {
          Federated = aws_iam_openid_connect_provider.github.arn
        }
        Condition = {
           StringLike: {
             "token.actions.githubusercontent.com:sub" = "repo:jlui70/dvn-workshop-dia-04:*"
           }
           StringEquals = {
             "token.actions.githubusercontent.com:aud": "sts.amazonaws.com"
           }
         }
      },
    ]
  })
}



resource "aws_iam_policy" "github" {
  name        = "GitHubActionProjectDevopPolicy"
  
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
            "ecr:GetAuthorizationToken"
        ]
        Resource = "*"
        },
        {
        Effect = "Allow"
        Action = [
          "ecr:BatchGetImage",
          "ecr:BatchCheckLayerAvailability",
          "ecr:CompleteLayerUpload",
          "ecr:GetDownloadUrlForLayer",
          "ecr:InitiateLayerUpload",
          "ecr:PutImage",
          "ecr:UploadLayerPart"
        ]
        Resource = aws_ecr_repository.this[*].arn
        },
      ]
    })
}

resource "aws_iam_role_policy_attachment" "github" {
  policy_arn = aws_iam_policy.github.arn
  role       = aws_iam_role.github.name
}
