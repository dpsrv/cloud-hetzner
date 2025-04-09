resource "hcloud_volume" "dpsrv-data" {
  count    = var.HCLOUD_SERVER_COUNT
  name     = "dpsrv-data"
  size     = 50
  format   = "ext4"
  location = data.hcloud_location.current.name
}

resource "hcloud_volume_attachment" "dpsrv-data" {
  count     = var.HCLOUD_SERVER_COUNT
  volume_id = hcloud_volume.dpsrv-data[count.index].id
  server_id = hcloud_server.dpsrv[count.index].id
  automount = true
}

