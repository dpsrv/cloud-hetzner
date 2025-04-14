#!/opt/local/bin/bash -ex
. ../secrets/setenv.sh
terraform-1.11.3 "$@"
git commit -a -m updated
git push

