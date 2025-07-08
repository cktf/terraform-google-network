resource "google_compute_route" "this" {
  for_each = var.routes

  name        = coalesce(each.value.name, "${var.name}-${each.key}")
  tags        = each.value.tags
  priority    = each.value.priority
  description = each.value.description
  dest_range  = each.value.destination
  network     = google_compute_network.this.self_link

  next_hop_ip            = startswith(each.value.next_hop, "ip:") ? split(":", each.value.next_hop)[1] : null
  next_hop_ilb           = startswith(each.value.next_hop, "ilb:") ? split(":", each.value.next_hop)[1] : null
  next_hop_gateway       = startswith(each.value.next_hop, "gateway:") ? split(":", each.value.next_hop)[1] : null
  next_hop_instance      = startswith(each.value.next_hop, "instance:") ? split(":", each.value.next_hop)[1] : null
  next_hop_vpn_tunnel    = startswith(each.value.next_hop, "vpn_tunnel:") ? split(":", each.value.next_hop)[1] : null
  next_hop_instance_zone = startswith(each.value.next_hop, "instance:") ? split(":", each.value.next_hop)[2] : null
}
