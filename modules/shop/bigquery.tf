resource "google_bigquery_dataset" "shop_dataset" {
  dataset_id = "shop45_dataset"
  location   = "US"
}

resource "google_bigquery_table" "shop_table" {
  dataset_id  = google_bigquery_dataset.shop_dataset.dataset_id
  project     = "t-12-vm"
  table_id    = "shop_data"
  description = "This table contain sales data of Shop45"
  deletion_protection = false


}

resource "google_bigquery_job" "job889" {
  job_id = "job_load78"
  location = "US"

  labels = {
    "my_job" = "load"
  }

  load {
    source_uris = [
      "gs://${google_storage_bucket.my_storage.name}/${google_storage_bucket_object.shop_data_csv.name}",
    ]

    destination_table {
      project_id = google_bigquery_table.shop_table.project
      dataset_id = google_bigquery_table.shop_table.dataset_id
      table_id   = google_bigquery_table.shop_table.table_id
    }
    skip_leading_rows     = 0
    autodetect        = true

  }
}