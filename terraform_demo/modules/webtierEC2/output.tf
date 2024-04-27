output "webtier_IP" {
    value = aws_instance.webtier.*.public_ip
}