variable "project_id" {
  description = "The Google Cloud Project ID"
  default     = "project-159f8b70-d160-49e0-a48"
}

variable "region" {
  description = "The default compute region"
  default     = "asia-southeast1"
}

variable "bucket_name" {
  description = "The globally unique name of GCS Data Lake Bucket"
  default     = "ecommerce_sales_data_lake-project-159f8b70-d160-49e0-a48"
}

variable "dataset_id" {
  description = "The name of the BigQuery Data Warehouse dataset"
  default     = "ecommerce_sales_dataset"
}