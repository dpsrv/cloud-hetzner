data "template_file" "user_data" {
  count    = var.HCLOUD_SERVER_COUNT
  template = file("user_data")
  vars = {
    hcloud_volume_data_id = hcloud_volume.dpsrv-data[count.index].id
    hcloud_ssh_key_dpsrv  = hcloud_ssh_key.dpsrv.public_key

    DPSRV_REGION          = "hc-${data.hcloud_location.current.name}"
    DPSRV_NODE            = "${count.index + 1}"
  }
}

resource "hcloud_server" "dpsrv" {
  count        = var.HCLOUD_SERVER_COUNT
  name         = "hc-${data.hcloud_location.current.name}-${count.index + 1}"
  image        = "fedora-40"
  allow_deprecated_images = true
  server_type  = var.HCLOUD_SERVER_TYPE
  location     = data.hcloud_location.current.name
  ssh_keys     = [hcloud_ssh_key.dpsrv.id]
  firewall_ids = [hcloud_firewall.dpsrv.id]
  user_data    = data.template_file.user_data[count.index].rendered
}

