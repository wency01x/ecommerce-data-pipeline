#!/bin/bash

# Build the new docker image
docker build -t ecommerce-pipeline:v1 .

# Run the docker container and mount personal gcloud folder
docker run -it \
  -v ~/.config/gcloud:/root/.config/gcloud \
  -e GCP_PROJECT=project-159f8b70-d160-49e0-a48 \
  ecommerce-pipeline:v1 \
  --table_name=sales_data \
  --csv_name=online_retail_II_dataset.csv