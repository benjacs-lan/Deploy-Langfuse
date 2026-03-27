# aws politicas de aaceso a s3
resource "aws_iam_policy" "langsfuse_s3_policy" {
  name        = "langsfuse-S3-Acces-Policy"
  description = "Permite a langsfuse leer y escribir en el bucket S3"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject",
          "s3:ListBucket"
        ]
        Effect = "Allow"
        Resource = [
          "arn:aws:s3:::langsfuse-bucket",
          "arn:aws:s3:::langsfuse-bucket/*"
        ]
      }
    ]
  })
}

resource "aws_iam_role" "langsfuse_app_role" {
  name        = "langsfuse-app-role"
  description = "Rol para  la aplicacion langsfuse"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com" # Modificar a EKS een caso de usar kubernetes
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "langsfuse_s3_attachment" {
  role       = aws_iam_role.langsfuse_app_role.name
  policy_arn = aws_iam_policy.langsfuse_s3_policy.arn
}
