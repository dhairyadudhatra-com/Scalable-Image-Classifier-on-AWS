resource "aws_launch_template" "apptier_template"{
    name = "apptier_template"
    image_id = var.ami_id
    instance_type = "t2.micro"
    vpc_security_group_ids = [var.apptier_sg_id]
    
    block_device_mappings {
        device_name = "/dev/sda1"
        ebs {
            volume_size = 25
            delete_on_termination = true
            encrypted = true
        }
    }
    iam_instance_profile {
        name = var.apptier_IAM_profile
    }
    tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "apptier-instance"
    }
  }
    user_data = filebase64("${path.module}/apptier.sh")
}

resource "aws_autoscaling_group" "apptier_asg" {
    name = "apptier_asg"
    vpc_zone_identifier = [var.subnet_id]
    max_size = 20
    min_size = 1
    launch_template {
        id = aws_launch_template.apptier_template.id
        version = "$Latest"
    }
}

resource "aws_autoscaling_policy" "upscale_policy" {
    name = "upscale_policy"
    autoscaling_group_name = aws_autoscaling_group.apptier_asg.name
    adjustment_type = "ChangeInCapacity"
    policy_type = "StepScaling"
    step_adjustment {
        scaling_adjustment = 2
        metric_interval_lower_bound = 5
    }
}

resource "aws_autoscaling_policy" "downscale_policy" {
    name = "downscale_policy"
    autoscaling_group_name = aws_autoscaling_group.apptier_asg.name
    adjustment_type = "ChangeInCapacity"
    policy_type = "StepScaling"
    step_adjustment {
        scaling_adjustment = -2
        metric_interval_lower_bound = 0
        
    }
}
