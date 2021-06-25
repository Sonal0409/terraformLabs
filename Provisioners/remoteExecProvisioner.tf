provider "aws" {
  region     = "us-west-2"
  access_key = "your_access_key"
  secret_key = "your_secret_key"
}

# Write the resource code to create ec2_instance_id, provisioner and connection in same block.

resource "aws_instance" "myec2" {
  ami = "ami-0800fc0fa715fdcfe"
  instance_type = "t2.micro"
  key_name = "TFkey"
  # since at the bottom we are using the pem key to connect to the instance for executing commands, so here you have to
  # mentione the key name with which this instance will be created.
  # Now the ec2-instance will be created with this specific key TFkey.pem

  # lets add a provisioner here, the type of provisioner will be remote-exec
  # and we will add an inline also, inline allows to add list of commands that will be executed in the ec2-instance.
provisioner "remote-exec" {
    inline = [
# here you cna put list of commands like:
# command1 : install nginx
"sudo amazon-linux-extras install -y nginx1.12",
# command2 : start nginx
"sudo systemctl start nginx"
  ]
  # Inside the provisioner we will write connection block now.
  # Now we will add a connection block here, so that terraform can connect to ec2-instance and perform the commands.
  # ie: we have to provide credientails or private key for terraform to loginto the ec2_instance
  # Create a key pair in aws ec2 service in the correct zone us-west-2 and that will download the keypair.pem file in your downloads folder
  # copy the keypair.pem file in to you current folder where you are writing the code ie:provisioners
connection {
  type = "ssh"
  user = "ec2-user"
  # here you have to use file function ie: file(path) that will fetch the .pem file from current directory.
  private_key = file("./TFkey.pem")
  host = self.public_ip
  # here you are providing the address of resource that terraform has to make connection to.
  # as connection block is in the same aws_instance resource so we are writing self.
}
}
}
