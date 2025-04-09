resource "hcloud_floating_ip" "dpsrv" {
  count         = var.HCLOUD_SERVER_COUNT
  type          = "ipv4"
  home_location = data.hcloud_location.current.name
}

resource "hcloud_floating_ip_assignment" "dpsrv" {
  count          = var.HCLOUD_SERVER_COUNT
  floating_ip_id = hcloud_floating_ip.dpsrv[count.index].id
  server_id      = hcloud_server.dpsrv[count.index].id
}

resource "hcloud_rdns" "dpsrv" {
  count          = var.HCLOUD_SERVER_COUNT
  floating_ip_id = hcloud_floating_ip.dpsrv[count.index].id
  ip_address     = hcloud_floating_ip.dpsrv[count.index].ip_address
  dns_ptr        = "hc-${data.hcloud_location.current.name}-${count.index + 1}.dpsrv.me"
}

