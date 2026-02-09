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
    default = "sg-0be38400b55ebbe0c"
} 
variable "api_termination" {
  default = true
} 

variable "nosofinstances" {
  default = 2
}


#data types 
#  1    =   number 
#  "anup", "1" = string 
#  true  = boolean 
#  2.1 = float  