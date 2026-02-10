data "aws_vpc" "default" {
  default = true
}

 data "aws_subnets" "default" {
    filter {
        name = "vpc-id"
        values = [data.aws_vpc.default.id]
    }
}
# infrastructure , auto-scaling group, load balancer, target group, listener, security group, launch template 
##are be their

# from 15 to 31 security group be their
resource "aws_security_group" "web_sg" {
  name        = "web-sg"
  vpc_id      = data.aws_vpc.default.id

    ingress {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"] 
    }
}

# from 33 to 39 load balancer be their
resource "aws_lb" "app_lb" {
  name               = "simple-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.web_sg.id]
  subnets            = [data.aws_subnets.default.id]
}

# from 41 to 47 target group be their And 48 vpc id be taken 
resource "aws_lb_target_group" "tg" {
  name     = "simple-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.default.id
}

# from 49 to 55 listener be their
resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.app_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}

resource "aws_launch_template" "web_lt" {
  name_prefix   = "simple_template"
  image_id      = var.instanceami
  instance_type = var.instancetype
  key_name      = var.keyname

  network_interfaces {
    security_groups = [aws_security_group.web_sg.id]
    subnets_id       = data.aws_subnets.default.ids
  }

  user_data = base64encode(<<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              systemctl start httpd
              systemctl enable httpd
              echo "Hello World from $(hostname -f)" > /var/www/html/index.html
              EOF
      )
}

# auto-scaling group be their
resource "aws_autoscaling_group" "web_asg" {
  desired_capacity          = 2
  max_size                  = 2
  min_size                  = 1
  vpc_zone_identifier       = data.aws_subnets.default.ids
  target_group_arns         = [aws_lb_target_group.tg.arn]
  health_check_type        = "ELB"
  health_check_grace_period = 120

  launch_template {
    id      = aws_launch_template.web_lt.id
    version = "$Latest"
  }
  
}

output "lb_dns_name" {
  value = aws_lb.app_lb.dns_name
}
