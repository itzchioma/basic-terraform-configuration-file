# app-server instance configuration
resource "aws_instance" "app-server" {
  ami                    = var.ami
  instance_type          = var.instance
  subnet_id              = aws_subnet.app-subnet.id
  vpc_security_group_ids = [aws_security_group.security_group.id]
  key_name               = "dev_key"

  user_data = <<-EOF
    #!/bin/bash
    apt update -y
    apt install nginx -y
    systemctl start nginx
    systemctl enable nginx
  EOF

  tags = {
    Name = "${var.project_name}-app-subnet"
  }
}
