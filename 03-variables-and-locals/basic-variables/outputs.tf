output "instance_info" {
  description = "Instance information"
  value = {
    id         = aws_instance.example.id
    public_ip  = aws_instance.example.public_ip
    private_ip = aws_instance.example.private_ip
  }
}

output "tags_applied" {
  description = "Tags applied to the instance"
  value = aws_instance.example.tags
}