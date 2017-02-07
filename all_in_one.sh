set -e
export BUCKET_NAME=zeitgeist-store-1234
export STAGING_BUCKET_NAME=zeitgeist-store-1234
# sh ./bootstrap.sh
# sh ./delete-cluster.sh
sh ./populate_titan.sh
sh ./deploy_core.sh
