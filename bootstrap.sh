CLUSTER_NAME="${CLUSTER_NAME:-my-dataproc-cluster}"
gsutil cp create-cluster.sh gs://$BUCKET_NAME
gcloud dataproc clusters create $CLUSTER_NAME \
    --metadata "MINICONDA_VARIANT=3,BUCKET_NAME=$BUCKET_NAME" \
    --initialization-actions \
        gs://$BUCKET_NAME/create-cluster.sh \
    --bucket $STAGING_BUCKET_NAME \
    --num-workers 2 \
    --scopes cloud-platform \
    --worker-machine-type=n1-highmem-2 \
    --master-machine-type=n1-highmem-4
