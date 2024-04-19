variable "region" {
  default = "us-east-1"
}
variable "project_name" {
  default = "dev"
}
variable "vpc_cidr" {
  default = "10.0.0.0/16"
}
variable "web-subnet" {
  default = "10.0.0.0/24"
}
variable "app-subnet" {
  default = "10.0.1.0/24"
}
variable "ami" {
  default = "ami-080e1f13689e07408"
}
variable "instance" {
  default = "t2.micro"
}
variable "nat-subnet" {
  default = "10.0.2.0/24"
}
