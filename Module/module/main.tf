module "ec2" {
    source = "/home/yashraj/terraform/Module/main/ec2" #to specify the location of the module
    webserver_ami = "ami-019715e0d74f695be"
    webserver_instance_type = "t2.micro"
    webserver_key_name = "jenkins"
    webserver_subnetA = module.vpc.subnetA_id
    webserver_sg_id = module.vpc.webserver_sg

}

module "vpc" {
    source = "/home/yashraj/terraform/Module/main/vpc" #to specify the location of the module
    vpc_cidr = "172.30.0.0/16"
    vpc_subnetA = "172.30.1.0/24"
    public_ip = true

}