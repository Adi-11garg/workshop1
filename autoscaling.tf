#Create Security group for ASG
resource "aws_security_group" "workshop_asg_sg" {
    vpc_id = aws_vpc.workshop1-vpc.id
    name = "ASG Security Group"
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = [
            "0.0.0.0/0"
        ]
    }
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        security_groups = [ 
            aws_security_group.workshop_alb_sg.id 
        ]
    }
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        security_groups = [
            aws_security_group.workshop-sg.id 
        ]
    }
    tags = {
        Name = "Workshop ASG Security Group"
        Terraform = "True"
    }
}

#ASG Policy
resource "aws_autoscaling_policy" "workshop-asg-policy" {
    name = "autoscaling-policy"
    policy_type = "TargetTrackingScaling"
    autoscaling_group_name = aws_autoscaling_group.workshop_front_end.name 
    target_tracking_configuration {
      predefined_metric_specification {
        predefined_metric_type = "ASGAverageCPUUtilization"
      }
      target_value = 40.0
    }
}


#Create launch configuration

resource "aws_launch_configuration" "workshop_launch_config" {
    name_prefix = "Workshop Launch Configuration"
    image_id = "ami-0fb653ca2d3203ac1"
    instance_type = "t2.micro"
    security_groups = [aws_security_group.workshop_asg_sg.id]
    key_name = "aditya"
    lifecycle {
      create_before_destroy = true
    }
}

#Create frontend ASG

resource "aws_autoscaling_group" "workshop_front_end" {
    name = "Workshop ASG"
    launch_configuration = aws_launch_configuration.workshop_launch_config.name 
    health_check_type = "ELB"
    min_size = 2
    max_size = 6
    desired_capacity = 2

    vpc_zone_identifier = [
        aws_subnet.workshop1-private-1a.id,
        aws_subnet.workshop1-private-1b.id
    ]
    target_group_arns = [aws_lb_target_group.workshop-front-end-tg.arn]
    lifecycle {
        create_before_destroy = true
    }
    tag {
        key = "Name"
        value = "Workshop ASG"
        propagate_at_launch = true 
    }
}
