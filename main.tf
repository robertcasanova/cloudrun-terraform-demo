terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.67.0"
    }
  }

  required_version = ">= 0.14"
}

provider "google" {
  // in the real world the Service Account to run terraform must be a secret in CI/CD pipeline using GOOGLE_CREDENTIALS env
  credentials = file("credentials/SA.json")

  project = var.project_id
  region  = var.region
}

# enable GCP apis on project
module "project-services" {
  source                      = "terraform-google-modules/project-factory/google//modules/project_services"
  version                     = "~> 14.2"
  disable_services_on_destroy = false

  project_id = var.project_id

  activate_apis = [
    "compute.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "cloudapis.googleapis.com",
    "servicenetworking.googleapis.com",
    "storage.googleapis.com",
    "run.googleapis.com",
    "containerregistry.googleapis.com",
    "iam.googleapis.com",
    "iamcredentials.googleapis.com",
    "logging.googleapis.com",
    "monitoring.googleapis.com",
    "secretmanager.googleapis.com",
  ]
}