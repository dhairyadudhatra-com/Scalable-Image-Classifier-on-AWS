
# Create EC2 instance using the retrieved AMI ID and referenced resources
resource "aws_instance" "webtier" {
  ami           = var.ami_id
  instance_type = "t2.micro"
  count = 1
  subnet_id = var.subnet_id
  associate_public_ip_address = true
  user_data = filebase64("${path.module}/webtier.sh")

  user_data_replace_on_change = true
  vpc_security_group_ids = [var.web_apptier_sg_id] 
  iam_instance_profile = var.webtier_IAM_profile
  tags = {
    Name        = "webtier-instance"
  }
}
