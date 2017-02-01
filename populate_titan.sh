git clone https://H-Plus-Time/zeitgeist-data.git
cd zeitgeist-data
gcloud dataproc jobs submit pyspark ingest-graph-dataproc.py
cd ..
