variable "project_id" {
  type        = string
  description = "The GCP project id"
}

variable "region" {
  type        = string
  default     = "europe-west6"
  description = "The GCP region for non global resources"
}

variable "service_name" {
  type        = string
  description = "The name of the service"
}

variable "service_host" {
  type        = string
  description = "The domain name (es: demopa.example.com)"
}

variable "service_path" {
  type        = string
  description = "The path for the service (es: /demo-service)"
}

variable "service_image" {
  type = string
  description = "Docker container image for the service"
}

variable "service_container_concurrency" {
  type = number
  default = 100
  description = "Max concurrent reqs for each container before scale up"
}

variable "service_max_containers" {
  type = number
  default = 5
  description = "Max containers running together"
}

variable "alerts_mail" {
  type        = string
  description = "Mail for incidents notification"
}

