output "network" {
  value = {
    id        = google_compute_network.this.id
    name      = google_compute_network.this.name
    self_link = google_compute_network.this.self_link
  }
  description = "The created VPC network"
}

output "subnets" {
  value = {
    for key, subnet in google_compute_subnetwork.this : key => {
      id            = subnet.id
      name          = subnet.name
      self_link     = subnet.self_link
      ip_cidr_range = subnet.ip_cidr_range
      region        = subnet.region
    }
  }
  description = "The created subnet resources"
}

output "firewall_rules" {
  value = {
    for key, rule in google_compute_firewall.this : key => {
      id        = rule.id
      name      = rule.name
      self_link = rule.self_link
    }
  }
  description = "The created firewall rules"
}

output "routes" {
  value = {
    for key, route in google_compute_route.this : key => {
      id        = route.id
      name      = route.name
      self_link = route.self_link
    }
  }
  description = "The created routes"
}
