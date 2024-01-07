resource "terraform_data" "post-apply" {
  triggers_replace = [
    hcloud_server.dpsrv.id
  ]

  provisioner "local-exec" {
    command = <<-EOT
		while ! ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no root@${hcloud_server.dpsrv.ipv4_address} "mkdir -p ~/.config/git"; do
			echo "Waiting for the server to become available"
			sleep 2
		done
		scp -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no ~/.config/git/openssl-* root@${hcloud_server.dpsrv.ipv4_address}:.config/git/
		scp -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no ~/.gitconfig root@${hcloud_server.dpsrv.ipv4_address}:.gitconfig
	EOT
  }

  depends_on = [
    hcloud_server.dpsrv
  ]
}
