resource "aws_instance" "webserver" {
  ami           = var.webserver_ami
  instance_type = var.webserver_instance_type
  key_name      = var.webserver_key_name
  subnet_id     = var.webserver_subnetA
  vpc_security_group_ids = var.webserver_sg

}
