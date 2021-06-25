
variable "vpn_ip"{
  default="116.30.45.50/32"
}
# example for variable at CLI
# variable "instancetype"{}

# Example for variable value to be taken as default
# type variable type : default
variable "instancetype" {
default="t2.nano"
}
