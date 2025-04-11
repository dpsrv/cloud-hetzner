#!/opt/local/bin/bash -ex

terraform-1.11.3 "$@"
git commit -a -m updated
git push

