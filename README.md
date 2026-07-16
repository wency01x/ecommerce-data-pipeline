# E-Commerce Data Ingestion Pipeline

![Python](https://img.shields.io/badge/python-3670A0?style=for-the-badge&logo=python&logoColor=ffdd54)
![Docker](https://img.shields.io/badge/docker-%230db7ed.svg?style=for-the-badge&logo=docker&logoColor=white)
![Postgres](https://img.shields.io/badge/postgres-%23316192.svg?style=for-the-badge&logo=postgresql&logoColor=white)
![Terraform](https://img.shields.io/badge/terraform-%235835CC.svg?style=for-the-badge&logo=terraform&logoColor=white)

A Dockerized ETL pipeline that extracts, cleans, and loads large datasets into PostgreSQL, featuring Terraform IaC for Cloud deployment.

### Core Features

*   **Memory-Efficient Extraction:** Uses Pandas chunking to process 500,000+ rows without crashing.
    ```python
    df_iter = pd.read_csv(csv_name, iterator=True, chunksize=100000)
    ```
*   **Data Quality Transformations:** Drops corrupted/anonymous records automatically.
    ```python
    df = df.dropna(subset=['Customer ID'])
    ```
*   **Idempotent Data Loading:** Safely resets and appends data to prevent duplicates on reruns.
    ```python
    df.head(n=0).to_sql(name=table_name, con=engine, if_exists='replace')
    ```
*   **Infrastructure as Code:** Includes `main.tf` for deploying a BigQuery Data Warehouse, optimized for Southeast Asia latency.
    ```terraform
    resource "google_bigquery_dataset" "ecommerce" {
      location = "asia-southeast1" 
    }
    ```
*   **Automated Execution:** Entire pipeline runs via a single shell script.
    ```bash
    ./run.sh
    ```