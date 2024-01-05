data "template_file" "user_data" {
  template = file("user_data")
}

resource "hcloud_server" "dpsrv" {
  name        = "dpsrv"
  image       = "fedora-39"
  server_type = var.HCLOUD_SERVER_TYPE
  location    = data.hcloud_location.current.name
  ssh_keys    = [hcloud_ssh_key.default.id]
  user_data   = data.template_file.user_data.rendered
}

