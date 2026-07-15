#!/bin/bash

echo "Building the Docker image..."
docker build -t sales_ingestor:v1 .

echo "Running the Data Ingestion Pipeline..."
docker run -it \
  --network=ecommerce-pipeline_ecommerce_net \
  sales_ingestor:v1 \
    --user=user \
    --password=password \
    --host=pgdatabase \
    --port=5432 \
    --db=database \
    --table_name=sales_data \
    --csv_name=online_retail_II_dataset.csv
