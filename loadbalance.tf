resource "aws_lb" "challenge2_lb" {
  name = "challenge2-lb"
  internal = false
  load_balancer_type = "network"
  subnets = ["subnet-0fa7f9cac27f5ef71","subnet-007582a567c5fc75b"]
  security_groups = [aws_security_group.lb_security_group.id]
}

resource "aws_lb_listener" "challenge2_lbl" {
  load_balancer_arn = aws_lb.challenge2_lb.arn
  port = 22
  protocol = "TCP"


  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.challenge2_lbt.arn
  }
}

resource "aws_lb_target_group" "challenge2_lbt" {
  name = "challenge2-lbt"
  port = 22
  protocol = "TCP"
  vpc_id = data.aws_vpcs.in_region.ids[0]

}