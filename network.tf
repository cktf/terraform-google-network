resource "google_compute_network" "this" {
  mtu                          = var.mtu
  name                         = var.name
  network_profile              = var.profile
  description                  = var.description
  routing_mode                 = var.routing_mode
  bgp_best_path_selection_mode = var.path_selection_mode
  bgp_always_compare_med       = var.path_selection_mode == "STANDARD" ? true : null
  bgp_inter_region_cost        = var.path_selection_mode == "STANDARD" ? "ADD_COST_TO_MED" : null

  auto_create_subnetworks                   = false
  delete_default_routes_on_create           = true
  enable_ula_internal_ipv6                  = true
  internal_ipv6_range                       = null
  network_firewall_policy_enforcement_order = "AFTER_CLASSIC_FIREWALL"
}

resource "google_compute_subnetwork" "this" {
  for_each = var.subnets

  name                    = each.value.name
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

resource "google_compute_route" "this" {
  for_each = var.routes

  name        = each.value.name
  tags        = each.value.tags
  priority    = each.value.priority
  description = each.value.description
  dest_range  = each.value.destination
  network     = google_compute_network.this.id

  next_hop_ip            = startswith(each.value.next_hop, "ip:") ? split(":", each.value.next_hop)[1] : null
  next_hop_ilb           = startswith(each.value.next_hop, "ilb:") ? split(":", each.value.next_hop)[1] : null
  next_hop_gateway       = startswith(each.value.next_hop, "gateway:") ? split(":", each.value.next_hop)[1] : null
  next_hop_instance      = startswith(each.value.next_hop, "instance:") ? split(":", each.value.next_hop)[1] : null
  next_hop_vpn_tunnel    = startswith(each.value.next_hop, "vpn_tunnel:") ? split(":", each.value.next_hop)[1] : null
  next_hop_instance_zone = startswith(each.value.next_hop, "instance:") ? split(":", each.value.next_hop)[2] : null
}
