#Create ALB Listener

resource "aws_lb_listener" "workshop_http" {
    load_balancer_arn = aws_lb.workshop_alb.arn 
    port = 80
    protocol = "HTTP"
    default_action {
      type = "forward"
      target_group_arn = aws_lb_target_group.workshop-front-end-tg.arn 
    }
}