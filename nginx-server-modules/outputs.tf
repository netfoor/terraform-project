output "server_ip" {
  description = "The public IP address of the server"
  value       = aws_instance.nginx.public_ip
  
}

output "server_public_dns" {
  description = "The public DNS of the server"
  value       = aws_instance.nginx.public_dns
  
}