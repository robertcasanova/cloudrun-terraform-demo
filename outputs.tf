output "public_ip" {
  description = "Service public IP address"
  value       = google_compute_global_address.load_balancer.address
}

output "public_url" {
  description = "Service public url"
  value       = "https://${var.service_host}${var.service_path}"
}