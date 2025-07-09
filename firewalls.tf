resource "google_compute_firewall" "this" {
  for_each = var.firewalls

  name        = coalesce(each.value.name, "${var.name}-${each.key}")
  priority    = each.value.priority
  disabled    = each.value.disabled
  direction   = each.value.direction
  description = each.value.description
  network     = google_compute_network.this.name

  source_tags             = [for value in each.value.sources : split(":", value)[1] if startswith(value, "tag:")]
  target_tags             = [for value in each.value.targets : split(":", value)[1] if startswith(value, "tag:")]
  source_ranges           = [for value in each.value.sources : split(":", value)[1] if startswith(value, "range:")]
  destination_ranges      = [for value in each.value.targets : split(":", value)[1] if startswith(value, "range:")]
  source_service_accounts = length([for value in each.value.sources : split(":", value)[1] if startswith(value, "service_account:")]) > 0 ? [for value in each.value.sources : split(":", value)[1] if startswith(value, "service_account:")] : null
  target_service_accounts = length([for value in each.value.targets : split(":", value)[1] if startswith(value, "service_account:")]) > 0 ? [for value in each.value.targets : split(":", value)[1] if startswith(value, "service_account:")] : null

  dynamic "allow" {
    for_each = { for item in each.value.allows : item => split(":", item) }
    content {
      protocol = allow.value[0]
      ports    = try(split(",", allow.value[1]), null)
    }
  }

  dynamic "deny" {
    for_each = { for item in each.value.denies : item => split(":", item) }
    content {
      protocol = deny.value[0]
      ports    = try(split(",", deny.value[1]), null)
    }
  }
}
