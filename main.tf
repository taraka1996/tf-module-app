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