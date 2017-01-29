mkdir -p /mnt/gcs-bucket/pubmed
OUTPUT_PATH=/mnt/gcs-bucket/pubmed
mkdir pubmed
apt-get install -y ncftp
wget http://downloads.exmachinatech.net/forqlift/0.9.0/forqlift-0.9.0.tar.bz2
tar -xf forqlift-0.9.0.tar.bz2 && mv forqlift-0.9.0 forqlift

ncftpls ftp://ftp.ncbi.nlm.nih.gov/pub/pmc/\*.xml.tar.gz >> xml_list.txt

while read p; do
  wget ftp://ftp.ncbi.nlm.nih.gov/pub/pmc/$p
done <xml_list.txt
rm xml_list.txt

./forqlift/bin/forqlift fromarchive --file=./pubmed_seq *.xml.tar.gz
