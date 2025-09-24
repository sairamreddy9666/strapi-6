resource "aws_ecr_repository" "strapi" {
name = "strapi-repo-${var.env}"
image_tag_mutability = "MUTABLE"
lifecycle {
prevent_destroy = false
}
}


output "ecr_repo_url" {
value = aws_ecr_repository.strapi.repository_url
}
