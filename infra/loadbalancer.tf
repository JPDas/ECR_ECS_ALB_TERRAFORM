resource "aws_lb" "my_lb" {
  name               = "my-load-balancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.ecs-securitygroup.id]
  subnets            = [aws_subnet.main-public-1.id, aws_subnet.main-public-2.id]

  tags = {
    Name = "my-load-balancer"
  }
}

resource "aws_alb_listener" "my_listener" {
  load_balancer_arn = aws_lb.my_lb.id
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.my_target_group.id
    type             = "forward"
  }
}