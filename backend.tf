# web-server instance configuration
resource "aws_instance" "app-server" {
  ami           = var.ami
  instance_type = var.instance
  subnet_id     = aws_subnet.app-subnet.id
  key_name      = "dev_key"

  tags = {
    Name = "app-subnet"
  }
}
