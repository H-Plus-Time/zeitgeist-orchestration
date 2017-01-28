CLUSTER_NAME="${CLUSTER_NAME:-my-dataproc-cluster}"

gcloud dataproc clusters delete $CLUSTER_NAME
