output "webserver_publicip" {
    value = aws_instance.webserver.public_ip
}

output "webserver_publicdns" {
    value = aws_instance.webserver.public_dns
}
