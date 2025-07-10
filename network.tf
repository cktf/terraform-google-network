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
  delete_default_routes_on_create           = false
  network_firewall_policy_enforcement_order = "AFTER_CLASSIC_FIREWALL"
}
