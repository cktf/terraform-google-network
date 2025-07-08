output "link" {
  value       = google_compute_network.this.self_link
  sensitive   = false
  description = "Network Link"
}

output "subnets" {
  value       = { for key, val in var.subnets : key => google_compute_subnetwork.this[key].self_link }
  sensitive   = false
  description = "Network Subnets"
}
