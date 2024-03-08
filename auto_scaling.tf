resource "aws_launch_configuration" "challenge2_alc" {
  name_prefix   = "challenge2-"
  image_id      = "ami-03bb6d83c60fc5f7c"
  instance_type = "t2.micro"
  key_name = "Project1"
  security_groups = [ aws_security_group.instance_security_group.id ]
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "challenge2_asg" {
  vpc_zone_identifier = ["subnet-0fa7f9cac27f5ef71","subnet-007582a567c5fc75b"]
  desired_capacity = 1
  max_size = 3
  min_size = 1
  launch_configuration = aws_launch_configuration.challenge2_alc.name
}

resource "aws_autoscaling_attachment" "challenge2_asa" {
  autoscaling_group_name = aws_autoscaling_group.challenge2_asg.id
  lb_target_group_arn = aws_lb_target_group.challenge2_lbt.arn
}

resource "aws_autoscaling_policy" "challenge2_asp_up" {
  name = "challenge2_asp_up"
  scaling_adjustment = 1
  adjustment_type = "ChangeInCapacity"
  cooldown = 100
  autoscaling_group_name = aws_autoscaling_group.challenge2_asg.name
}

resource "aws_autoscaling_policy" "challenge2_asp_down" {
  name = "challenge2_asp_down"
  scaling_adjustment = -1
  adjustment_type = "ChangeInCapacity"
  cooldown = 100
  autoscaling_group_name = aws_autoscaling_group.challenge2_asg.name
}