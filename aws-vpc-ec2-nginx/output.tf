output "instance_public_ip"  {
    value = aws_instance.ec2-ngx.public_ip
}

output "instance_url" {
  value = "http://${aws_instance.ec2-ngx.public_ip}"
}
