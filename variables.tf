variable "aws_region" {
  description = "AWS region"
  default     = "ap-northeast-1"
}

variable "ami_id" {
  description = "Amazon Linux 2 AMI ID for Tokyo"
  default     = "ami-0d5f5a4eaac1481cb"
}

variable "instance_type" {
  description = "EC2 instance type"
  default     = "t2.micro"
}

variable "key_name" {
  description = "Name of your AWS EC2 key pair"
  default     = "ec2-key"   # Change this if your key name differs
}
