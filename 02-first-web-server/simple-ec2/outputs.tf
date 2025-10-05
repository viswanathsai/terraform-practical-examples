# Outputs for Chapter 2
output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.main.id
}

output "instance_public_ip" {
  description = "Public IP address of the web server"
  value       = aws_instance.web_server.public_ip
}

output "website_url" {
  description = "URL to access the website"
  value       = "http://${aws_instance.web_server.public_ip}"
}

output "ssh_command" {
  description = "Command to SSH into the server"
  value       = "ssh -i ~/.ssh/id_rsa ec2-user@${aws_instance.web_server.public_ip}"
}