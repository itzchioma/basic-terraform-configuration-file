# Create a Key Pair
resource "aws_key_pair" "dev_key" {
  key_name   = "dev_key"
  public_key = tls_private_key.rsa.public_key_openssh
}

# RSA key of size 4096 bits
resource "tls_private_key" "rsa" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "dev-key" {
  content  = tls_private_key.rsa.private_key_pem
  filename = "tfkey"
}