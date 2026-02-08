resource "aws_instance" "webserver" {
    ami           = "ami-019715e0d74f695be"
    instance_type = "t2.micro"
    vpc_security_group_ids = ["sg-0f512ea37ba7d7f7a"] 
    key_name = "ubuntu"

    tags = {
        Name = "WebServer-instance"
        purpose = "learning terraform"
    }
    user_data = <<-EDF
                #!/bin/bash
                sudo apt update -y
                sudo apt install nginx -y
                EDF

}

resource "aws_security_group" "webserversg" {
    

          ingress {
            from_port   = 80
            to_port     = 80
            protocol    = "tcp"
            cidr_blocks = ["0.0.0.0/0"]
          }

         ingress {
            from_port   = 8080
            to_port     = 8080
            protocol    = "tcp"
            cidr_blocks = ["0.0.0.0/0"]
          }


          egress {
            from_port   = 0
            to_port     = 0
            protocol    = "-1"
            cidr_blocks = ["0.0.0.0/0"]
          }
}