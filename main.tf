module "nginx_server_dev" {
  source = "./nginx-server-modules" # Path to the module
  
  ami           = "ami-0440d3b780d96b29d" # Amazon Linux 2 AMI
  instance_type = "t2.micro"
  server_name   = "nginx-server-dev"
  environment   = "dev"
  ssh = "nginx-server.key.pub" # Path to the public key file
  
  
}

module "nginx_server_qa" {
  source = "./nginx-server-modules" # Path to the module
  
  ami           = "ami-0440d3b780d96b29d" # Amazon Linux 2 AMI
  instance_type = "t3.micro"
  server_name   = "nginx-server-qa"
  environment   = "qa"
  ssh = "nginx-server-qa.key.pub" # Path to the public key file
  
}

output "server_dev_ip" {
  description = "The public IP address of the server"
  value       = module.nginx_server_dev.server_ip
  
}

output "server_dev_public_dns" {
  description = "The public DNS of the server"
  value       = module.nginx_server_dev.server_public_dns
  
}

output "server_qa_ip" {
  description = "The public IP address of the server"
  value       = module.nginx_server_qa.server_ip
  
}

output "server_qa_public_dns" {
  description = "The public DNS of the server"
  value       = module.nginx_server_qa.server_public_dns
  
}

terraform {
  backend "s3" {
    bucket = "terraform-nginx-4-12-2025"
    key    = "terraform-project/terraform.tfstate"
    region = "us-east-1"
  }
}

# aws_instance.server-web:
resource "aws_instance" "server-web" {
    ami                                  = "ami-00a929b66ed6e0de6"
    instance_type                        = "t2.micro"
    vpc_security_group_ids               = [
        "sg-0a8485d9019f060e6",
    ]
    tags = {
    Name = "server-web"
    Environment = "test"
    Owner = "Fortino Romero"
    Team = "devops"
    Project = "server-web"
  }
}
