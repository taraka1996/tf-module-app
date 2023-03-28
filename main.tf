resource "aws_launch_template" "main" {
  name = "${var.component}-${var.env}"

 
  image_id = data.aws_ami.ami.id
  
  instance_market_options {
    market_type = "spot"
  }

  instance_type = var.instance_type

  tag_specifications {
    resource_type = "instance"

   tags = merge(
        var.tags, 
        { Name = "${var.component}- ${var.env}" }
    )
  }

 }
 resource "aws_autoscaling_group" "main" {
  name                = "${var.component}-${var.env}"
  desired_capacity    = var.desired_capacity
  max_size            = var.max_size
  min_size            = var.min_size
  vpc_zone_identifier = var.subnets
  target_group_arns   = [aws_lb_target_group.main.arn]

  launch_template {
    id      = aws_launch_template.main.id
    version = "$Latest"
  }

 } 