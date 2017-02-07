gcloud compute instances create titangraph-1 \
    --image=titan-graph \
    --machine-type=n1-highmem-8 \

gcloud compute ssh titangraph-1 --command "sudo gsutil cp gs://zeitgeist-store-1234/pubmed.graphson /root/pubmed.graphson"
gcloud compute ssh titangraph-1 --command "sudo gsutil cp gs://zeitgeist-store-1234/index_setup.groovy /root/index_setup.groovy"
gcloud compute ssh titangraph-1 --command "sudo gsutil cp gs://zeitgeist-store-1234/populate.groovy /root/populate.groovy"
gcloud compute ssh titangraph-1 --command "/root/titan/bin/titan.sh start"
gcloud compute ssh titangraph-1 --command "echo :quit | sudo /root/titan/bin/gremlin.sh /root/index_setup.groovy"
gcloud compute ssh titangraph-1 --command "echo :quit | sudo /root/titan/bin/gremlin.sh /root/populate.groovy"
