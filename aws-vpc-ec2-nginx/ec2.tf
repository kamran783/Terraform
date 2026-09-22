resource "aws_instance" "ec2-ngx" {
  ami                         = "ami-0199ac7c9fbf9ed83"
  instance_type               = "t3.micro"
  subnet_id                   = aws_subnet.public-subnet-ngx.id
  vpc_security_group_ids      = [aws_security_group.sg-ngx.id]
  associate_public_ip_address = true

  user_data = <<-EOF
                 #!/bin/bash
                 sudo apt-get update -y
                 sudo apt-get install -y nginx
                 EOF


  tags = {
    Name = "ec2-ngx"
  }
}
