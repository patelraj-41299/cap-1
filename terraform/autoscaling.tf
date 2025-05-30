resource "aws_autoscaling_group" "app_asg" {
  name                      = "app-asg"
  min_size                  = 2
  max_size                  = 4
  desired_capacity          = 2
  vpc_zone_identifier       = [
    aws_subnet.public_subnet_1.id,
    aws_subnet.public_subnet_2.id
  ]
  target_group_arns         = [aws_lb_target_group.app_tg.arn]
  health_check_type         = "EC2"

  launch_template {
    id      = aws_launch_template.app_lt.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "AppServer"
    propagate_at_launch = true
  }
}
