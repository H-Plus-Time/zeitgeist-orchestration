#!/usr/bin/env bash

BUCKET_NAME=$(/usr/share/google/get_metadata_value attributes/BUCKET_NAME || true)

CONDA_ENV_YAML_GSC_LOC="gs://$BUCKET_NAME/conda-environment.yml"
CONDA_ENV_YAML_PATH="/root/conda-environment.yml"
echo "Downloading conda environment at $CONDA_ENV_YAML_GSC_LOC to $CONDA_ENV_YAML_PATH ... "
gsutil -m cp -r $CONDA_ENV_YAML_GSC_LOC $CONDA_ENV_YAML_PATH
apt-get install dos2unix -y

export GCSFUSE_REPO=gcsfuse-`lsb_release -c -s`
echo "deb http://packages.cloud.google.com/apt $GCSFUSE_REPO main" | tee /etc/apt/sources.list.d/gcsfuse.list
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
#
apt-get update
apt-get install gcsfuse -y

mkdir -p /mnt/gcs-bucket
chmod a+w /mnt/gcs-bucket
gcsfuse --implicit-dirs $BUCKET_NAME /mnt/gcs-bucket &

# Install Miniconda / conda
gsutil -m cp gs://dataproc-initialization-actions/conda/bootstrap-conda.sh ./bootstrap-conda.sh && dos2unix ./bootstrap-conda.sh
chmod +x ./bootstrap-conda.sh
./bootstrap-conda.sh

gsutil -m cp gs://dataproc-initialization-actions/conda/install-conda-env.sh ./install-conda-env.sh && dos2unix ./install-conda-env.sh
chmod +x ./install-conda-env.sh
# Create / Update conda environment via conda yaml
CONDA_ENV_YAML=$CONDA_ENV_YAML_PATH ./install-conda-env.sh
