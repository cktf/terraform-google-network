resource "google_compute_network" "this" {
  mtu                             = var.mtu
  name                            = var.name
  description                     = var.description
  routing_mode                    = var.routing_mode
  auto_create_subnetworks         = false
  delete_default_routes_on_create = true

  bgp_best_path_selection_mode = ""
  bgp_always_compare_med       = ""
  bgp_inter_region_cost        = ""

  network_firewall_policy_enforcement_order = ""
  enable_ula_internal_ipv6                  = ""
  internal_ipv6_range                       = ""
  network_profile                           = ""
}

resource "google_compute_subnetwork" "this" {
  name          = var.name
  region        = "us-central1"
  network       = google_compute_network.this.id
  description   = var.description
  ip_cidr_range = "192.168.${var.segment}.0/24"

  reserved_internal_range = ""
  secondary_ip_range {
    range_name              = ""
    ip_cidr_range           = ""
    reserved_internal_range = ""
  }

  stack_type                       = ""
  ipv6_access_type                 = ""
  external_ipv6_prefix             = ""
  ip_collection                    = ""
  send_secondary_ip_range_if_empty = true

  purpose = ""
  role    = ""

  private_ip_google_access   = true
  private_ipv6_google_access = true
}

resource "google_compute_route" "this" {
  name        = var.name
  network     = google_compute_network.this.id
  description = var.description

  tags       = []
  priority   = 2000
  dest_range = "0.0.0.0/0"

  next_hop_ip            = ""
  next_hop_ilb           = ""
  next_hop_gateway       = "default-internet-gateway"
  next_hop_instance      = ""
  next_hop_vpn_tunnel    = ""
  next_hop_instance_zone = ""
}
