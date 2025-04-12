

resource "aws_key_pair" "nginx-ssh" {
  key_name   = "${var.server_name}-ssh"
  public_key = file("${var.ssh}") # Path to the public key file
  
  tags = {
    Name = "${var.server_name}-ssh"
    Environment = var.environment
    Owner = var.owner
    Team = var.Team 
    Project = var.Project
  }
  
}