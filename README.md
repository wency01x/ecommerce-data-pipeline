# E-Commerce Data Ingestion Pipeline

A containerized Data Engineering ETL pipeline that extracts, cleans, and loads massive E-Commerce datasets into a PostgreSQL Data Warehouse. 

### Core Features:
*   **Memory-Efficient Extraction:** Uses Python and Pandas to ingest 500,000+ rows of raw data in chunks of 100,000, preventing memory crashes.
*   **Data Quality Transformations:** Implements automated data cleaning to filter out corrupted or missing customer records before ingestion.
*   **Containerized Infrastructure:** Utilizes Docker Compose to spin up an isolated PostgreSQL database and pgAdmin network, while the ingestion script runs in its own custom Docker image.
*   **Infrastructure as Code (IaC):** Includes Terraform configuration (`main.tf`) architected to deploy a Google Cloud Storage Data Lake and BigQuery Data Warehouse optimized for Southeast Asia network latency.
*   **Automated Execution:** Fully automated via a single `./run.sh` shell script.