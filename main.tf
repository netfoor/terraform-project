// This is the main Terraform configuration file for AWS infrastructure setup.
// It includes the provider configuration, S3 bucket creation, and IAM role setup.
provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "nginx" {
  ami           = "ami-0440d3b780d96b29d" // Amazon Linux 2 AMI
  instance_type = "t3.micro"

  tags = {
    Name = "nginx-instance"
  }
  
}