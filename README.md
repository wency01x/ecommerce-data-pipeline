# Cloud-Native Ecommerce Data Pipeline

![Google Cloud](https://img.shields.io/badge/GoogleCloud-%234285F4.svg?style=for-the-badge&logo=google-cloud&logoColor=white)
![Terraform](https://img.shields.io/badge/terraform-%235835CC.svg?style=for-the-badge&logo=terraform&logoColor=white)
![Docker](https://img.shields.io/badge/docker-%230db7ed.svg?style=for-the-badge&logo=docker&logoColor=white)
![Python](https://img.shields.io/badge/python-3670A0?style=for-the-badge&logo=python&logoColor=ffdd54)
![Pandas](https://img.shields.io/badge/pandas-%23150458.svg?style=for-the-badge&logo=pandas&logoColor=white)

## Project Overview
A professional, cloud-native **ELT (Extract, Load, Transform)** data pipeline that ingests over 1 million rows of raw ecommerce sales data directly into Google Cloud. 

This project demonstrates modern Data Engineering principles by abandoning local databases (like PostgreSQL) in favor of infinitely scalable, managed cloud infrastructure.

## Architecture & Workflow

1. **Infrastructure as Code (IaC)**
   *   **Terraform** is used to programmatically provision the entire cloud environment, ensuring the infrastructure is reproducible and version-controlled.
   *   **Resources Created:** A Google Cloud Storage Bucket (Data Lake) and a Google BigQuery Dataset (Data Warehouse).
2. **Data Extraction & Ingestion**
   *   A **Python** script leverages the `pandas` and `pandas_gbq` libraries to read a massive CSV dataset and stream it securely to the cloud.
   *   The pipeline relies on **Google Application Default Credentials (ADC)** or Service Account keys for secure, zero-trust authentication.
3. **Containerization**
   *   The ingestion environment is packaged into a **Docker** container to ensure perfectly isolated and reproducible runs across any machine or cloud server.
4. **Data Warehouse & Analytics**
   *   The data lands in **Google BigQuery**, where it is instantly available for high-speed SQL queries and analytical transformations.

## How to Run

### 1. Provision the Cloud Infrastructure
Authenticate with Google Cloud and use Terraform to build the Data Lake and Warehouse:
```bash
gcloud auth application-default login
terraform init
terraform plan
terraform apply
```

### 2. Run the Ingestion Pipeline
To run the containerized ELT pipeline locally:
```bash
# Build the Docker image
docker build -t ecommerce-pipeline:v1 .

# Run the container (Mapping Google Cloud credentials)
docker run -it \
  -v ~/.config/gcloud:/root/.config/gcloud \
  -e GCP_PROJECT=your-project-id \
  ecommerce-pipeline:v1 \
  --table_name=sales_data \
  --csv_name=online_retail_II_dataset.csv
```
*(Alternatively, simply run `python3 ingest_sales.py --table_name=sales_data --csv_name=online_retail_II_dataset.csv` via a local virtual environment).*

### 3. Query the Data
Open the [Google Cloud BigQuery Console](https://console.cloud.google.com/bigquery) and run your SQL analytics:
```sql
SELECT * FROM `ecommerce_sales_dataset.sales_data` LIMIT 1000;
```

## Future Enhancements
*   [ ] **Orchestration:** Implement **Apache Airflow** to automate the pipeline to run on a daily schedule.
*   [ ] **Data Transformation:** Integrate **dbt (data build tool)** to build materialized views and clean the raw BigQuery data.
*   [ ] **Visualization:** Connect the BigQuery dataset to Looker Studio to build an automated revenue dashboard.