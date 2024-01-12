data "template_file" "user_data" {
  template = file("user_data")
  vars = {
    hcloud_volume_data_id = hcloud_volume.dpsrv-data.id
    hcloud_ssh_key_dpsrv  = hcloud_ssh_key.dpsrv.public_key
  }
}

resource "hcloud_server" "dpsrv" {
  name         = "hc-ash-1"
  image        = "fedora-39"
  server_type  = var.HCLOUD_SERVER_TYPE
  location     = data.hcloud_location.current.name
  ssh_keys     = [hcloud_ssh_key.dpsrv.id]
  firewall_ids = [hcloud_firewall.dpsrv.id]
  user_data    = data.template_file.user_data.rendered
}

