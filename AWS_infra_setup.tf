provider "aws" {
  region     = "us-west-2"
  shared_credentials_file = "~/.aws/credentials"
}

resource "aws_vpc" "edu-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
  Name = "edureka"
}
}

 resource "aws_subnet" "subnet-1" {
   vpc_id            = aws_vpc.edu-vpc.id
   cidr_block        = "10.0.1.0/24"
   map_public_ip_on_launch = true
   depends_on = [aws_vpc.edu-vpc]
   availability_zone = "us-west-2a"
   tags = {
     Name = "edu-subnet"
   }
 }

resource "aws_route_table" "edu-route-table" {
vpc_id = aws_vpc.edu-vpc.id
 tags = {
     Name = "edureka"
   }
 }

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.subnet-1.id
  route_table_id = aws_route_table.edu-route-table.id
}

resource "aws_internet_gateway" "gw" {
 vpc_id = aws_vpc.edu-vpc.id
depends_on = [aws_vpc.edu-vpc]
 }

resource "aws_route" "edu-route" {
 route_table_id = aws_route_table.edu-route-table.id
 destination_cidr_block = "0.0.0.0/0"
 gateway_id = aws_internet_gateway.gw.id
 }

resource "aws_security_group" "allow_web" {
   name        = "allow_web_traffic"
   description = "Allow Web inbound traffic"
     vpc_id      = aws_vpc.edu-vpc.id
ingress {
     description = "HTTPS"
     from_port   = 443
     to_port     = 443
     protocol    = "tcp"
     cidr_blocks = ["0.0.0.0/0"]
}
ingress {
     description = "HTTP"
     from_port   = 80
     to_port     = 80
     protocol    = "tcp"
     cidr_blocks = ["0.0.0.0/0"]
   }
   ingress {
     description = "SSH"
     from_port   = 22
     to_port     = 22
     protocol    = "tcp"
     cidr_blocks = ["0.0.0.0/0"]
   }
   egress {
     from_port   = 0
     to_port     = 0
     protocol    = "-1"
     cidr_blocks = ["0.0.0.0/0"]
   }

   tags = {
     Name = "allow_web"
   }
 }

# create a private key that will be used to loginto website

resource "tls_private_key" "web-key" {
 algorithm = "RSA"
}

resource "aws_key_pair" "app-instance-key" {

 key_name = "web-key"
 public_key = tls_private_key.web-key.public_key_openssh
}

# save the key to local

resource local_file "web-key" {

 content = tls_private_key.web-key.private_key_pem
 filename = "web-key.pem"
}

resource "aws_instance" "web" {
  ami           = var.ami
  instance_type = var.instance_type
  count = 1
  tags = {
    Name = "${var.environment}-${count.index}"
  }
  subnet_id = aws_subnet.subnet-1.id
  key_name = "web-key"
  security_groups = [aws_security_group.allow_web.id]

  provisioner "remote-exec" {
    connection {
     type = "ssh"
     user = "ec2-user"
     private_key = tls_private_key.web-key.private_key_pem
     host = aws_instance.web[0].public_ip
    }
  inline = [
    "sudo yum install httpd php git -y",
    "sudo systemctl restart httpd",
    "sudo systemctl enable httpd"
  ]


}
}
