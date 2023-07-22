resource "google_service_account" "cloudrun_service_sa" {
  account_id = "${var.service_name}-sa"
}

resource "google_cloud_run_service" "main" {
  name     = var.service_name
  location = var.region

  template {
    spec {
      containers {
        image = var.service_image
        startup_probe {
          http_get {
            path = "/readyz"
          }
        }
        liveness_probe {
          http_get {
            path = "/livez"
          }
          period_seconds = 30
        }
      }
      // handle max 200 concurrent requests for this container
      container_concurrency = var.service_container_concurrency
      service_account_name = google_service_account.cloudrun_service_sa.email
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }

  metadata {
    annotations = {
      # Allow requests only from LB or same VPC network
      "run.googleapis.com/ingress" = "internal-and-cloud-load-balancing"
      "autoscaling.knative.dev/maxScale" = var.service_max_containers
    }
  }
}

data "google_iam_policy" "noauth" {
  binding {
    role = "roles/run.invoker"
    members = [
      "allUsers",
    ]
  }
}

resource "google_cloud_run_service_iam_policy" "noauth" {
  location = google_cloud_run_service.main.location
  project  = google_cloud_run_service.main.project
  service  = google_cloud_run_service.main.name

  policy_data = data.google_iam_policy.noauth.policy_data
}