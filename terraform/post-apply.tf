resource "terraform_data" "post-apply" {
  count = var.HCLOUD_SERVER_COUNT

  triggers_replace = [
    hcloud_server.dpsrv[count.index].id
  ]

  provisioner "local-exec" {
    command = <<-EOT
		while ! ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no root@${hcloud_server.dpsrv[count.index].ipv4_address} "mkdir -p ~/.config/git"; do
			echo "Waiting for the server to become available"
			sleep 2
		done
		scp -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no ~/.git-credentials root@${hcloud_server.dpsrv[count.index].ipv4_address}:.git-credentials
		scp -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no ~/.gitconfig root@${hcloud_server.dpsrv[count.index].ipv4_address}:.gitconfig
		scp -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no ~/.config/git/openssl-* root@${hcloud_server.dpsrv[count.index].ipv4_address}:.config/git/
	EOT
  }

  depends_on = [
    hcloud_server.dpsrv
  ]
}
