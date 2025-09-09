resource "opentelekomcloud_vpc_eip_v1" "vpc_eip" {
  region      = var.region
  tags        = var.tags
  unbind_port = var.unbind_port

  dynamic "publicip" {
    for_each = var.publicip != null ? [var.publicip] : []

    content {
      type       = publicip.value.type
      ip_address = publicip.value.ip_address
      port_id    = publicip.value.port_id
      name       = publicip.value.name
    }
  }

  dynamic "bandwidth" {
    for_each = var.bandwidth != null ? [var.bandwidth] : []

    content {
      name        = bandwidth.value.name
      size        = bandwidth.value.size
      share_type  = bandwidth.value.share_type
      charge_mode = bandwidth.value.charge_mode
    }
  }

  dynamic "timeouts" {
    for_each = var.timeouts != null ? [var.timeouts] : []

    content {
      create = timeouts.value.create
      delete = timeouts.value.delete
    }
  }
}

resource "opentelekomcloud_networking_floatingip_associate_v2" "vip_eip_associate_1" {
  for_each    = var.floatingip_associate != null ? { "this" = var.floatingip_associate } : {}
  floating_ip = opentelekomcloud_vpc_eip_v1.vpc_eip.publicip[0].ip_address
  port_id     = each.value.port_id
}
