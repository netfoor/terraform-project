
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