resource "google_compute_firewall" "this" {
  for_each = var.firewalls

  name        = coalesce(each.value.name, "${var.name}-${each.key}")
  network     = google_compute_network.this.name
  description = each.value.description
  direction   = ""
  priority    = each.value.priority
  disabled    = false

  source_tags = each.value.source_tags
  target_tags = each.value.target_tags

  source_ranges      = each.value.source_ranges
  destination_ranges = ""

  source_service_accounts = each.value.source_service_accounts
  target_service_accounts = each.value.target_service_accounts

  dynamic "allow" {
    for_each = each.value.allowed_rules
    content {
      protocol = allow.value.protocol
      ports    = allow.value.ports
    }
  }

  dynamic "deny" {
    for_each = each.value.denied_rules
    content {
      protocol = deny.value.protocol
      ports    = deny.value.ports
    }
  }
}
