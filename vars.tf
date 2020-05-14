variable "region" { 
   default= "ap-south-1"
}

variable "vpc-cidr" {
   default= "192.168.0.0/16"
}

variable "tenancy" {
   default= "default"
}

/*data "aws_availability_zones" "azs" { 
     state= "available"
}*/
   
variable "sub-cidrs" {
    default= "192.168.1.0/24"
}

#variable "access_key" { }
#variable "secret_key" { }
variable "ami" { }
variable "key" {
  default= "prod-key"
}


