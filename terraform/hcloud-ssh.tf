resource "hcloud_ssh_key" "default" {
  name       = "dpsrv"
  public_key = file("~/.ssh/id_rsa.pub")
}
