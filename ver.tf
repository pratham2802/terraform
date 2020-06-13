variable "cidr_vpc" {
  default = "172.40.0.0/16"
}

variable "subnet_priv1" {
  default = "172.40.1.0/24"
}

variable "subnet_priv2" {
  default = "172.40.2.0/24"
}

variable "subnet_pub1" {
  default = "172.40.6.0/24"
}

variable "subnet_pub2" {
  default = "172.40.7.0/24"
}

variable "az_1" {
  default = "ap-southeast-1a"
}

variable "az_2" {
  default = "ap-southeast-1b"
}

variable "ami_id" {
  default = "ami-007c250ec30978d40"
}

variable "regi" {
  default = "ap-south-1"
}

variable "key" {
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCMBpdKXrCjhpEszXwxaRwjI9kBinurzVOm4q5kXTNEjA1QLCLwnsAMi43VKZ95x5vp+qJoMM+so9h1dMTQ72+SdFrTVk5XcWlNSi3xqSznYdCbFbvSVBAcpLXvgv0Zi6LmpOeJNoahxFUdvy0kmu/aNU72CiGIlJmcg42wFrsvULXATRnfeHrj6zqqCUIvFsfno08hwZIoJg2S3YFXieKjCFVQafI4VnSkNj6VtPgLKzEVX3HeK0AmhMxt939brIJzqhZG1VCeBIm6yTKEqwgnbWQbx7M8DeoMfoTrtjWzvAShGeFYyvvs2lfLMkZqb5ANSNNRTzNvrQGvv2vV3/rj imported-openssh-key"
}

variable "instance_type" {
  default = "t2.micro"
}
