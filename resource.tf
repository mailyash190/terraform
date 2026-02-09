resource "aws_instance" "Webserver" {
    ami           = var.instanceami
    instance_type = var.instancetype
    vpc_security_group_ids = [var.sg,aws_security_group.webserversg.id , data.aws_security_group.sg_gui.id] 
    key_name = var.keyname
    count = var.number_of_instances
    disable_api_termination = var.api_termination #instance cannot be terminated using API calls, it can only be terminated from the console

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

data "aws_security_group" "sg_gui" {
  name = "efs1"
}   #data block to fetch the security group id of efs1 security group and use it in aws_instance resource block
