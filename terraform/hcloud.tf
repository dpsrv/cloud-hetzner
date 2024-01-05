provider "hcloud" {
  token = var.HCLOUD_TOKEN
}

data "hcloud_location" "current" {
  name = var.HCLOUD_LOCATION
}
