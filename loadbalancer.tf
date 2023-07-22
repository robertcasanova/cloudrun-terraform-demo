# Public IP 

resource "google_compute_global_address" "load_balancer" {
  name = "lb-external-static-ip"
}

# Load Balancer Frontend

resource "google_compute_global_forwarding_rule" "load_balancer_https" {
  provider              = google-beta
  project               = var.project_id
  name                  = "lb-https-fe"
  target                = google_compute_target_https_proxy.load_balancer.self_link
  ip_address            = google_compute_global_address.load_balancer.address
  port_range            = "443"
  load_balancing_scheme = "EXTERNAL"
}
resource "google_compute_global_forwarding_rule" "load_balancer_http" {
  provider              = google-beta
  project               = var.project_id
  name                  = "lb-http-fe"
  target                = google_compute_target_http_proxy.load_balancer.self_link
  ip_address            = google_compute_global_address.load_balancer.address
  port_range            = "80"
  load_balancing_scheme = "EXTERNAL"
}
resource "google_compute_target_https_proxy" "load_balancer" {
  project          = var.project_id
  name             = "lb-https-proxy"
  url_map          = google_compute_url_map.load_balancer.id
  ssl_certificates = [google_compute_ssl_certificate.load_balancer.id]
}
resource "google_compute_target_http_proxy" "load_balancer" {
  project = var.project_id
  name    = "lb-http-proxy"
  url_map = google_compute_url_map.load_balancer_http_to_https.id
}
resource "google_compute_ssl_certificate" "load_balancer" {
  project     = var.project_id
  name_prefix = "lb-ssl-certificate"
  private_key = file("letsencrypt/live/${var.service_host}/privkey.pem") // must be on GCP Secret Manager
  certificate = file("letsencrypt/live/${var.service_host}/cert.pem")

  lifecycle {
    create_before_destroy = true
  }
}

# Load Balancer Routing

resource "google_compute_url_map" "load_balancer" {
  project = var.project_id
  name    = "lb-https"

  default_service = google_compute_backend_service.load_balancer.id

  host_rule {
    hosts        = [var.service_host]
    path_matcher = "paths"
  }

  path_matcher {
    default_service = google_compute_backend_service.load_balancer.id
    name            = "paths"
  }
}
resource "google_compute_url_map" "load_balancer_http_to_https" {
  project = var.project_id
  name    = "lb-http-to-https"
  default_url_redirect {
    https_redirect         = true
    redirect_response_code = "MOVED_PERMANENTLY_DEFAULT"
    strip_query            = false
  }
}

# Load Balancer Backend

resource "google_compute_backend_service" "load_balancer" {
  project    = var.project_id
  name       = "lb-bkend"
  enable_cdn = false
  backend {
    group = google_compute_region_network_endpoint_group.load_balancer.id
  }
}
resource "google_compute_region_network_endpoint_group" "load_balancer" {
  project               = var.project_id
  name                  = "lb-bkend-neg"
  network_endpoint_type = "SERVERLESS"
  region                = var.region
  cloud_run {
    service = google_cloud_run_service.main.name
  }
}



