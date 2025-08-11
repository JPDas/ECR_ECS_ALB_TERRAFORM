resource "aws_lb_target_group" "my_target_group" {
  name        = "my-target-group"
  port        = "80"
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "my-target-group"
  }
}