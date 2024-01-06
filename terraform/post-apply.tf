resource "terraform_data" "post-apply" {
  triggers_replace = [
    hcloud_server.dpsrv.id
  ]

  provisioner "local-exec" {
    command = <<-EOT
		ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no root@${hcloud_server.dpsrv.ipv4_address} "mkdir -p ~/.config/git"
		scp -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no ~/.config/git/openssl-* root@${hcloud_server.dpsrv.ipv4_address}:.config/git/
	EOT
  }

  depends_on = [
    hcloud_server.dpsrv
  ]
}
