output "subnetA_id" {
  value = aws_subnet.cdz_subnetA.id
}

output "vpc_id" {
  value = aws_vpc.cdz_vpc.id
}

output "webserversg_id" {
  value = aws_security_group.webserversg.id
} 

output "webserversg_Arn" {
  value = aws_security_group.webserversg.arn
}