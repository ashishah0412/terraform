
resource "aws_eip" "PublicIP" {
  domain = "vpc"
}

output "elasticIP" {
  value = aws_eip.PublicIP.public_ip
  /* You can as well give only "aws_eip.PublicIP" to get all the generated attributes listed in output*/
}