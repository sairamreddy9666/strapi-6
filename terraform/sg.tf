resource "aws_security_group" "alb_sg" {
name = "alb-sg-${var.env}"
description = "Allow HTTP inbound from internet"
vpc_id = data.aws_vpc.default.id


ingress {
description = "HTTP"
from_port = 80
to_port = 80
protocol = "tcp"
cidr_blocks = ["0.0.0.0/0"]
}


egress {
from_port = 0
to_port = 0
protocol = "-1"
cidr_blocks = ["0.0.0.0/0"]
}
}
