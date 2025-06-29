resource "google_compute_firewall" "this" {
  for_each = var.firewalls

  name        = each.value.name
  priority    = each.value.priority
  disabled    = each.value.disabled
  direction   = each.value.direction
  description = each.value.description
  network     = google_compute_network.this.name

  source_tags             = [for value in each.value.sources : split(":", value)[1] if startswith(value, "tag:")]
  target_tags             = [for value in each.value.sources : split(":", value)[1] if startswith(value, "tag:")]
  source_ranges           = [for value in each.value.sources : split(":", value)[1] if startswith(value, "range:")]
  destination_ranges      = [for value in each.value.sources : split(":", value)[1] if startswith(value, "range:")]
  source_service_accounts = [for value in each.value.sources : split(":", value)[1] if startswith(value, "service_account:")]
  target_service_accounts = [for value in each.value.sources : split(":", value)[1] if startswith(value, "service_account:")]

  dynamic "allow" {
    for_each = each.value.allow
    content {
      protocol = allow.value.protocol
      ports    = allow.value.ports
    }
  }

  dynamic "deny" {
    for_each = each.value.deny
    content {
      protocol = deny.value.protocol
      ports    = deny.value.ports
    }
  }
}
