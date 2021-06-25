provider "aws" {
  region     = "us-west-2"
  access_key = "your_access_key"
  secret_key = "your_secret_key"
}
# Example: Commandline flag

resource "aws_instance" "myec2" {
  ami = "ami-0800fc0fa715fdcfe"
  # here the value is hardcoded and static, lets parametrize it.
#  instance_type = "t2.micro"
# instance_type = var.variablename given in variablesfile
  instance_type = var.instancetype

}
# variable Example: Variable default
resource "aws_security_group" "sg2" {
  name   = "mysg1"
  ingress {

    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
  # instead of hard coding the values of ipaddress in loacation 1,2,3, as shown below
  # you can use variable and reference the value from source file which is variables.tf
  #  cidr_blocks      = ["116.30.45.50/32"]
  cidr_blocks= [var.vpn_ip]

  }
  ingress {

    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
# use variable instead of static values
  #  cidr_blocks      = ["116.30.45.50/32"]

    cidr_blocks= [var.vpn_ip]

  }
  ingress {

    from_port        = 53
    to_port          = 53
    protocol         = "tcp"

    #cidr_blocks      = ["116.30.45.50/32"]
      cidr_blocks= [var.vpn_ip]
  }
}

# if there is any chnage in ipaddress, you can again agin for variables.tf file
# and then update the new variable value
# the new variable value will automatically reference in this code file.
