resource "google_compute_subnetwork" "this" {
  for_each = var.subnets

  name                    = coalesce(each.value.name, "${var.name}-${each.key}")
  ip_cidr_range           = each.value.cidr
  region                  = each.value.region
  description             = each.value.description
  reserved_internal_range = each.value.reserved
  purpose                 = each.value.purpose
  role                    = each.value.role
  network                 = google_compute_network.this.id

  dynamic "secondary_ip_range" {
    for_each = each.value.secondaries
    content {
      range_name              = secondary_ip_range.value.name
      ip_cidr_range           = secondary_ip_range.value.cidr
      reserved_internal_range = secondary_ip_range.value.reserved
    }
  }

  private_ip_google_access         = true
  private_ipv6_google_access       = true
  send_secondary_ip_range_if_empty = true

  # TODO: implement IPv6 subnets
  stack_type           = "IPV4_ONLY"
  ipv6_access_type     = null
  external_ipv6_prefix = null
  ip_collection        = null
}
