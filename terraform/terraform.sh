#!/opt/local/bin/bash -ex

action=${1:-apply}
terraform-1.11.3 $action -state=../secrets/terraform.tfstate -auto-approve
git commit -a -m updated
git push

