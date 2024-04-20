# web-server instance configuration
resource "aws_instance" "web-server" {
  ami                    = var.ami
  instance_type          = var.instance
  subnet_id              = aws_subnet.web-subnet.id
  vpc_security_group_ids = [aws_security_group.security_group.id]
  key_name               = "dev_key"

  tags = {
    Name = "${var.project_name}-web-server"
  }
}

