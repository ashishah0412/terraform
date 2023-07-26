provider "aws" {
  #access_key = "your_access_key"
  #secret_key = "your_secret_key"
  region     = "eu-west-2"
}

resource "aws_vpc" "myfirstvpc" {
  cidr_block = "10.0.0.0/16"
}