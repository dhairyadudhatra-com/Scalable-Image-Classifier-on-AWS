variable vpc_id {
  type        = string
  default     = null
}

resource "aws_security_group" "TierSG"{
    name = "TierSG"
    description = "Allow HTTP,SSH,HTTPS inbound traffic"
    tags = {
        Name = "TierSG"
    }
    vpc_id = var.vpc_id
}

resource "aws_security_group_rule" "TierSG_Inbound_SSH" {
    type = "ingress"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    security_group_id = aws_security_group.TierSG.id
}

resource "aws_security_group_rule" "TierSG_Inbound_HTTP" {
    type = "ingress"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    security_group_id = aws_security_group.TierSG.id
}
resource "aws_security_group_rule" "TierSG_Inbound_HTTPS" {
    type = "ingress"
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    security_group_id = aws_security_group.TierSG.id
}
resource "aws_security_group_rule" "TierSG_Outbound" {
    type = "egress"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    security_group_id = aws_security_group.TierSG.id
}
