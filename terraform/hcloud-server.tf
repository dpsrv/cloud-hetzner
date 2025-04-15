data "template_file" "user_data" {
  count    = var.HCLOUD_SERVER_COUNT
  template = file("user_data.fedora41")
  vars = {
    HCLOUD_VOLUME_DATA_ID = hcloud_volume.dpsrv-data[count.index].id
    HCLOUD_SSH_KEY_DPSRV  = hcloud_ssh_key.dpsrv.public_key

    DPSRV_REGION = "hc-${data.hcloud_location.current.name}"
    DPSRV_NODE   = "${count.index + 1}"
  }
}

resource "hcloud_server" "dpsrv" {
  count = var.HCLOUD_SERVER_COUNT
  name  = "hc-${data.hcloud_location.current.name}-${count.index + 1}"
  image = "fedora-41"

  #allow_deprecated_images = true

  server_type  = var.HCLOUD_SERVER_TYPE
  location     = data.hcloud_location.current.name
  ssh_keys     = [hcloud_ssh_key.dpsrv.id]
  firewall_ids = [hcloud_firewall.dpsrv.id]
  user_data    = data.template_file.user_data[count.index].rendered
}

