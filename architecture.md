# Zeitgeist

## Backend requirements
 * Golang ingest Pubmed XML
 * REST API (Golang, Node, Python - pick one)
 * DSE Graph cluster

## Qualification requirements
 * cloud database
 * distributed off-line analysis (in the OLAP sense)
 * Web frontend of some kind
 * proper deployment (zeitgeist.hplustime.com perhaps?)

## Frontend requirements
 * Polymer shell (done)
 * Pinned terms (offline)
 * Line plots a la Google trends (prior work)
 * small-scale word associativity network (rank by strength, select top 20)

## Repositories
* zeitgeist-core - strictly OLTP api (small-scale online traversals, comms with web front end)
* zeitgeist-front - strictly (polymer) frontend code, no backend implementation details whatsoever
* zeitgeist-data - strictly fetching and processing of data (namely Pubmed XML), deposition into DSE cluster and Google Cloud Datastore
* zeitgeist-orchestration - glue code to automate spinning up and tearing down code
### post-project completion
Three deployment steps:
1. Deploy backend (concurrent)
    a. Spin up VMs, containers, populate data. On completion, nuke the old VMs/containers, assign old domains to new VMs/containers.
    b. Spin up API server, deploy api code
2. Push frontend to static host (surge)
