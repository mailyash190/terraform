variable "instanceami" {
    default =   "ami-019715e0d74f695be"
} 

variable "instancetype" {
   default = "t3.micro"
}

variable "keyname" {
   default = "jenkins"
}

variable "sg" {
    default = "sg-054f85db2427ca0b3"
} 
##variable "api_termination" { #for disabling API termination of the instance
  ##default = true
#} 

##variable "nosofinstances" {
  ##default = 2
##}


#data types 
#  1    =   number 
#  "anup", "1" = string 
#  true  = boolean 
#  2.1 = float  