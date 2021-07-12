Download Terraform:

https://www.terraform.io/downloads.html

Terraform Installation on Windows:
*************************************

Go to https://www.terraform.io/downloads.html
Scroll downto Windows package
Click on 64-bit

It will download the terraform zip file in downloads folder

Now create a folder with name as Binaries in C drive
Unzip the terrform file in the Binaries folder
The terraform.exe file will be availablein the binaries folder

On Windows set the environment variable

Path Variable and click on New , add the path C:\Binaries

You can check the installation is correct or not :

Create folder on desktop as terraformLabs

open cmd prompt

cd C:\Users\vishal mittal\Desktop\terraformLabs

execute command # terraform

You see it works perfectly well!!

*******************************************
Installation for MAC & Linux

Note steps are same for both OS


Go to https://www.terraform.io/downloads.html
Scroll downto Linux 
right click on 64-bit and copy the link

go to linux termial and fetch the binary

# wget https://releases.hashicorp.com/terraform/1.0.2/terraform_1.0.2_linux_amd64.zip

# unzip terraform_1.0.2_linux.zip

# ls
terraform binary will be available

# terraform ==> its work as expected

move file to the correct path

# mv terraform /usr/local/bin

Done. your installation is complete

************************************














