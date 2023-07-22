## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14 |
| <a name="requirement_google"></a> [google](#requirement\_google) | 4.67.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 4.67.0 |
| <a name="provider_google-beta"></a> [google-beta](#provider\_google-beta) | 4.67.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_project-services"></a> [project-services](#module\_project-services) | terraform-google-modules/project-factory/google//modules/project_services | ~> 14.2 |

## Resources

| Name | Type |
|------|------|
| [google-beta_google_compute_global_forwarding_rule.load_balancer_http](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_compute_global_forwarding_rule) | resource |
| [google-beta_google_compute_global_forwarding_rule.load_balancer_https](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_compute_global_forwarding_rule) | resource |
| [google_cloud_run_service.main](https://registry.terraform.io/providers/hashicorp/google/4.67.0/docs/resources/cloud_run_service) | resource |
| [google_cloud_run_service_iam_policy.noauth](https://registry.terraform.io/providers/hashicorp/google/4.67.0/docs/resources/cloud_run_service_iam_policy) | resource |
| [google_compute_backend_service.load_balancer](https://registry.terraform.io/providers/hashicorp/google/4.67.0/docs/resources/compute_backend_service) | resource |
| [google_compute_global_address.load_balancer](https://registry.terraform.io/providers/hashicorp/google/4.67.0/docs/resources/compute_global_address) | resource |
| [google_compute_region_network_endpoint_group.load_balancer](https://registry.terraform.io/providers/hashicorp/google/4.67.0/docs/resources/compute_region_network_endpoint_group) | resource |
| [google_compute_ssl_certificate.load_balancer](https://registry.terraform.io/providers/hashicorp/google/4.67.0/docs/resources/compute_ssl_certificate) | resource |
| [google_compute_target_http_proxy.load_balancer](https://registry.terraform.io/providers/hashicorp/google/4.67.0/docs/resources/compute_target_http_proxy) | resource |
| [google_compute_target_https_proxy.load_balancer](https://registry.terraform.io/providers/hashicorp/google/4.67.0/docs/resources/compute_target_https_proxy) | resource |
| [google_compute_url_map.load_balancer](https://registry.terraform.io/providers/hashicorp/google/4.67.0/docs/resources/compute_url_map) | resource |
| [google_compute_url_map.load_balancer_http_to_https](https://registry.terraform.io/providers/hashicorp/google/4.67.0/docs/resources/compute_url_map) | resource |
| [google_monitoring_alert_policy.main](https://registry.terraform.io/providers/hashicorp/google/4.67.0/docs/resources/monitoring_alert_policy) | resource |
| [google_monitoring_notification_channel.main](https://registry.terraform.io/providers/hashicorp/google/4.67.0/docs/resources/monitoring_notification_channel) | resource |
| [google_service_account.cloudrun_service_sa](https://registry.terraform.io/providers/hashicorp/google/4.67.0/docs/resources/service_account) | resource |
| [google_iam_policy.noauth](https://registry.terraform.io/providers/hashicorp/google/4.67.0/docs/data-sources/iam_policy) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alerts_mail"></a> [alerts\_mail](#input\_alerts\_mail) | Mail for incidents notification | `string` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The GCP project id | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The GCP region for non global resources | `string` | `"europe-west6"` | no |
| <a name="input_service_container_concurrency"></a> [service\_container\_concurrency](#input\_service\_container\_concurrency) | Max concurrent reqs for each container before scale up | `number` | `100` | no |
| <a name="input_service_host"></a> [service\_host](#input\_service\_host) | The domain name (es: demopa.example.com) | `string` | n/a | yes |
| <a name="input_service_image"></a> [service\_image](#input\_service\_image) | Docker container image for the service | `string` | n/a | yes |
| <a name="input_service_max_containers"></a> [service\_max\_containers](#input\_service\_max\_containers) | Max containers running together | `number` | `5` | no |
| <a name="input_service_name"></a> [service\_name](#input\_service\_name) | The name of the service | `string` | n/a | yes |
| <a name="input_service_path"></a> [service\_path](#input\_service\_path) | The path for the service (es: /demo-service) | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_public_ip"></a> [public\_ip](#output\_public\_ip) | Service public IP address |
| <a name="output_public_url"></a> [public\_url](#output\_public\_url) | Service public url |
