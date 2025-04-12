variable "ami" {
  description = "AMI ID for the EC2 instance"
  type        = string
  default     = "ami-0440d3b780d96b29d" // Amazon Linux 2 AMI
}

variable "instance_type" {
  description = "Instance type for the EC2 instance"
  type        = string
  default     = "t3.micro"
}

variable "server_name" {
  description = "Name of the server"
  type        = string
  default     = "nginx"
}


variable "environment" {
  description = "Environment for the server"
  type        = string
  default     = "test"
}

variable "owner" {
  description = "Owner of the server"
  type        = string
  default     = "Fortino Romero"
}

variable "Team" {
  description = "Team responsible for the server"
  type        = string
  default     = "devops"  
  
}

variable "Project" {
  description = "Project name"
  type        = string
  default     = "nginx-server"
}