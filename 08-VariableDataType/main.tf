# Resource definition
resource "aws_instance" "example" {
  ami           = "ami-072ec8f4ea4a6f2cf"
  instance_type = var.instancetype
}