variable "instanceami" {
    default =   "ami-0b6c6ebed2801a5cb"
} 

variable "instancetype" {
  default     = "t3.micro"
}

variable "sg" {
    default     = "sg-0f512ea37ba7d7f7a"
}

variable "keyname" {
    default     = "ubuntu"
}
variable "api_termination" {
    default = true
}

variable "number_of_instances" {
    default = 2
}
