terraform {
  required_providers {
    hcloud = {
      source = "hetznercloud/hcloud"
    }
  }

  backend "local" {
    path = "../secrets/terraform.tfstate"
  }
}
