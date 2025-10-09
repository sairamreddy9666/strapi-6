variable "db_password" {
  description = "The password for Postgres database"
  type        = string
  default     = "Strapi123!"
}

variable "image_uri" {
  description = "Docker image URI for Strapi container"
  type        = string
}
