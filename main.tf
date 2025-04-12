// This is the main Terraform configuration file for AWS infrastructure setup.
// It includes the provider configuration, S3 bucket creation, and IAM role setup.
provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "nginx" {
  ami           = var.ami
  instance_type = var.instance_type

  tags = {
    Name = "${var.server_name}-instance"
    Environment = var.environment
    Owner = var.owner
    Team = var.Team
    Project = var.Project
  }

  // user_data is a script that runs on instance startup
  // It installs and starts Nginx web server
  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y nginx
              systemctl start nginx
              systemctl enable nginx
            EOF
  
  key_name = aws_key_pair.nginx-ssh.key_name // Reference to the key pair for SSH access
  vpc_security_group_ids = [aws_security_group.nginx-sg.id] // Reference to the security group

}

resource "aws_key_pair" "nginx-ssh" {
  key_name   = "${var.server_name}-ssh"
  public_key = file("nginx-server.key.pub") 
  
  tags = {
    Name = "${var.server_name}-ssh"
    Environment = var.environment
    Owner = var.owner
    Team = var.Team 
    Project = var.Project
  }
  
}

resource "aws_security_group" "nginx-sg" {
  name        = "${var.server_name}-sg"
  description = "Security group for Nginx server"

  ingress {
    description = "SSH access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP access"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  tags = {
    Name = "nginx-instance"
    Environment = var.environment
    Owner = var.owner
    Team = var.Team
    Project = var.Project
  }
}