variable "aws_region" {
  type        = string
  description = "Region de AWS simulada en localstack"
  default     = "us-east-1"
}

variable "bucket_name" {
  type        = string
  description = "Nombre del bucket S3"
  default     = "langsfuse-bucket"
}
