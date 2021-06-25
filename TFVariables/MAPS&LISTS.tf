provider "aws" {
  region     = "us-west-2"
  access_key = "your_access_key"
  secret_key = "your_secret_key"
}

resource "aws_instance" "myec2" {
   ami = "ami-082b5a644766e0e6f"
  # instance_type = var.list[1]
   instance_type = var.types["us-west-2"]

    instance_type = var.list[0]
}

variable "list" {
  type = list
  default = ["m5.large","m5.xlarge","t2.medium"]
}

variable "types" {
  type = map
  default = {
    us-east-1 = "t2.micro"
    us-west-2 = "t2.nano"
    ap-south-1 = "t2.small"
  }
}
