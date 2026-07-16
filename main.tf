terraform {
    required_providers {
        google = {
            source = "hashicorp/google"
            version = "5.6.0"
        }

    }
}

provider "google" {
    project = "ecommerce-pipeline-2026"
    region = "asia-southeast1"
}

# Create a Google Cloud Storage Bucket (Data Lake)
resource "google_storage_bucket" "data-lake-bucket" {
    name          = "ecommerce_sales_data_lake"
    location      = "asia-southeast1"
    force_destroy = true

    lifecycle_rule {
        condition {
            age = 30
        }
        action {
            type = "Delete"
        }
    }
}

# Create a Google BigQuery Dataset (Data Warehouse)
resource "google_bigquery_dataset" "ecommerce_dataset" {
    dataset_id                 = "ecommerce_sales_dataset"
    location                   = "asia-southeast1"
    delete_contents_on_destroy = true
}