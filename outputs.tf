output "id" {
  value       = google_compute_network.this.id
  sensitive   = false
  description = "Network ID"
}

output "subnets" {
  value       = { for key, val in var.subnets : key => google_compute_subnetwork.this[key].id }
  sensitive   = false
  description = "Network Subnets"
}
