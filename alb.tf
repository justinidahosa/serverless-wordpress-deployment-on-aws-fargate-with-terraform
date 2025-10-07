resource "aws_lb" "wp_alb" {
  name               = "wordpress-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = [
  aws_subnet.public_subnet_1.id,
  aws_subnet.public_subnet_2.id,
  aws_subnet.public_subnet_3.id
]
}

resource "aws_lb_target_group" "wp_tg" {
  name        = "wordpress-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.wordpress_vpc.id
  target_type = "ip" 

    health_check {
    path                = "/"
    matcher             = "200-302"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 5
  }
}


resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.wp_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.wp_tg.arn
  }
}
