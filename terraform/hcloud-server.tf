resource "hcloud_server" "dpsrv" {
  name        = "dpsrv"
  image       = "fedora-39"
  server_type = var.HCLOUD_SERVER_TYPE
  location    = data.hcloud_location.current.name
  ssh_keys    = [hcloud_ssh_key.default.id]
  user_data   = file("user_data")
}

