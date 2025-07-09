output "link" {
  value       = google_compute_network.this.self_link
  sensitive   = false
  description = "Network Link"
}

output "routes" {
  value       = { for key, val in var.routes : key => google_compute_route.this[key].self_link }
  sensitive   = false
  description = "Network Routes"
}

output "subnets" {
  value       = { for key, val in var.subnets : key => google_compute_subnetwork.this[key].self_link }
  sensitive   = false
  description = "Network Subnets"
}

output "firewalls" {
  value       = { for key, val in var.firewalls : key => google_compute_firewall.this[key].self_link }
  sensitive   = false
  description = "Network Firewalls"
}
