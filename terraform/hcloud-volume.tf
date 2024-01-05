resource "hcloud_volume" "dpsrv-data" {
  name     = "dpsrv-data"
  size     = 50
  format   = "ext4"
  location = data.hcloud_location.current.name
}

resource "hcloud_volume_attachment" "dpsrv-data" {
  volume_id = hcloud_volume.dpsrv-data.id
  server_id = hcloud_server.dpsrv.id
  automount = true
}

