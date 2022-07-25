# Create dataset in bigquery
resource "google_bigquery_dataset" "shop_dataset" {
  dataset_id = var.dataset
  location   = var.location
}

# Create table in bigquery
resource "google_bigquery_table" "shop_table" {
  dataset_id          = google_bigquery_dataset.shop_dataset.dataset_id
  project             = var.project_id
  table_id            = var.table_name
  description         = var.table_description
  deletion_protection = false


}

# Import data in table 
resource "google_bigquery_job" "import_job" {
  job_id   = "job_import_${random_id.random_job_id.hex}"
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
    skip_leading_rows = 0
    autodetect        = true

  }
}
# Run a query to create user_data table 
# This block has issues with query
# resource "google_bigquery_job" "user_data_job" {
#   job_id     = "job_query_${random_id.random_job_id.hex}"
#   location = "US"


# labels = {
#     "job_type" ="create_table"
#   }
#   query {
#     query = "CREATE TABLE t-12-vm.shop45_dataset.user_data AS SELECT first_name, last_name, email,FROM t-12-vm.shop45_dataset.shop_data"

#     destination_table {
#       project_id = google_bigquery_table.shop_table.project
#       dataset_id = google_bigquery_table.shop_table.dataset_id
#       table_id   = google_bigquery_table.shop_table.table_id
#     }
#    allow_large_results = true
#     flatten_results = true

#   }
#   depends_on = [
#     google_bigquery_job.import_job
#   ]
# }



# Export data in gcp bucket 
resource "google_bigquery_job" "export_jab" {
  job_id = "job_export_${random_id.random_job_id.hex}"
  extract {
    destination_uris = ["${google_storage_bucket.my_storage.url}/${var.user_data_csv}"]

    source_table {
      project_id = google_bigquery_table.shop_table.project
      dataset_id = google_bigquery_table.shop_table.dataset_id
      table_id   = google_bigquery_table.shop_table.table_id
    }


  }
  depends_on = [time_sleep.wait_60_seconds]
}


resource "random_id" "random_job_id" {
keepers = {
 ch = "${timestamp()}"
}
byte_length = 8
}

resource "null_resource" "previous" {}

resource "time_sleep" "wait_60_seconds" {
  depends_on = [null_resource.previous]

  create_duration = "60s"
}






