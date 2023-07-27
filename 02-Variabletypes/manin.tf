
/*
1. This script covers defining the "Variables" of different types - "String", "Number"
List", "Map" & defining "Local Variable"

2. Creates EC2 Instace of type "t2.micro" in each availability Zone

3. Terraform script through "tag" variable of type map applies Tags to the 
 EC2 Machines.

4. Uses inbuilt Merge Function

5. availability_zone = var.availability_zones[count.index % length(var.availability_zones)] 

In this line of code, count.index represents the index of the current iteration when creating instances with the aws_instance resource. The count parameter is specified as local.total_instances, which means Terraform will execute the resource block multiple times based on the value of local.total_instances.

The expression count.index % length(var.availability_zones) calculates the remainder of dividing the current count.index by the length of the var.availability_zones list. This operation ensures that the value of availability_zone cycles through the list of availability zones in a circular manner, distributing the EC2 instances across the specified availability zones evenly.

For example, if var.availability_zones contains three elements ("us-west-2a", "us-west-2b", and "us-west-2c"), and local.total_instances is set to 6, the instances will be distributed as follows:

Instance 0 (count.index = 0) will have availability zone "us-west-2a".
Instance 1 (count.index = 1) will have availability zone "us-west-2b".
Instance 2 (count.index = 2) will have availability zone "us-west-2c".
Instance 3 (count.index = 3) will have availability zone "us-west-2a" (cycling back to the first availability zone).
Instance 4 (count.index = 4) will have availability zone "us-west-2b" (cycling back to the second availability zone).
Instance 5 (count.index = 5) will have availability zone "us-west-2c" (cycling back to the third availability zone).
By using the modulus operator in this way, the instances are evenly distributed across the availability zones, making use of the full list in a circular fashion.

*/

# Input variables
variable "aws_region" {
  description = "AWS region where resources will be created"
  type        = string
  default     = "eu-west-2"
}

variable "instance_count" {
  description = "Number of EC2 instances to create"
  type        = number
  default     = 2
}

variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
  default     = ["eu-west-2a", "eu-west-2b", "eu-west-2c"]
}

variable "tags" {
  description = "Map of tags for EC2 instances"
  type        = map(string)
  default     = {
    Name        = "Example Instance"
    Environment = "Development"
  }
}

# Local variables
locals {
  instance_type = "t2.micro"
  total_instances = var.instance_count * length(var.availability_zones)
}

# Resource definition
resource "aws_instance" "example" {
  count         = local.total_instances
  ami           = "ami-020737107b4baaa50"
  instance_type = local.instance_type
  availability_zone = var.availability_zones[count.index % length(var.availability_zones)]

  tags = merge(var.tags, {
    "InstanceIndex" = count.index
  })
}

