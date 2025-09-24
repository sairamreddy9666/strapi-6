output "alb_url" {
description = "Public ALB DNS to access Strapi"
value = aws_lb.alb.dns_name
}


output "ecr_repo_url" {
value = aws_ecr_repository.strapi.repository_url
}
