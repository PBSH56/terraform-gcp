terraform {
  required_version = ">=1.1.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.28.0"
    }
  }
    backend "gcs" {
    bucket  = "tf-backend-bucket003434"
    prefix = "tfbackend"
    credentials = "key.json"
  }
}


