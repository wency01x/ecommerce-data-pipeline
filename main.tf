terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.6.0"
    }

  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

# Create a Google Cloud Storage Bucket (Data Lake)
resource "google_storage_bucket" "data-lake-bucket" {
  name                        = var.bucket_name
  location                    = var.region
  force_destroy               = true
  uniform_bucket_level_access = true

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
  dataset_id                 = var.dataset_id
  location                   = var.region
  delete_contents_on_destroy = true
}