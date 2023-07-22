resource "google_monitoring_alert_policy" "main" {
  display_name          = "Demo Service Status"
  combiner              = "OR"
  notification_channels = [google_monitoring_notification_channel.main.name]
  // Latency > 200ms for > 50% of sessions within 4 mins
  conditions {
    display_name = "Latency"
    condition_threshold {
      trigger {
        percent = 100
      }
      filter          = "metric.type=\"run.googleapis.com/request_latencies\" AND resource.type=\"cloud_run_revision\" AND resource.labels.service_name=\"${var.service_name}\""
      duration        = "240s"
      comparison      = "COMPARISON_GT"
      threshold_value = 200
      aggregations {
        alignment_period   = "240s"
        per_series_aligner = "ALIGN_PERCENTILE_50"
      }
    }
  }
  // More than 1 statusCode == 500 within 10 mins
  conditions {
    display_name = "Errors"
    condition_threshold {
      trigger {
        percent = 100
      }
      filter          = "resource.type = \"cloud_run_revision\" AND resource.labels.service_name = \"${var.service_name}\" AND metric.type = \"run.googleapis.com/request_count\" AND metric.labels.response_code = \"500\""
      duration        = "600s"
      comparison      = "COMPARISON_GT"
      threshold_value = 1
      aggregations {
        alignment_period   = "600s"
        per_series_aligner = "ALIGN_MAX"
      }
    }
  }
}

resource "google_monitoring_notification_channel" "main" {
  display_name = "Notification Mail"
  type         = "email"
  labels = {
    email_address = var.alerts_mail
  }
  force_delete = false
}
