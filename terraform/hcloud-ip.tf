resource "hcloud_floating_ip" "dpsrv" {
  type          = "ipv4"
  home_location = data.hcloud_location.current.name
}

resource "hcloud_floating_ip_assignment" "dpsrv" {
  floating_ip_id = hcloud_floating_ip.dpsrv.id
  server_id      = hcloud_server.dpsrv.id
}

