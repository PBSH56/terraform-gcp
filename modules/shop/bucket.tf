# create a cloud-storage 
resource "google_storage_bucket" "my_storage" {
  name          = var.bucket_name
  location      = var.location
  force_destroy = true
}

# upload csv file in bucket 
resource "google_storage_bucket_object" "shop_data_csv" {
  name   = var.source_name
  source = var.source_path
  bucket = google_storage_bucket.my_storage.name
}

# get pulic permissions for object 

resource "google_storage_object_access_control" "object-rules" {
  object = var.user_data_csv
  bucket = google_storage_bucket.my_storage.name
  role   = var.role
  entity = var.entity
  depends_on = [
    google_bigquery_job.export_jab
  ]
}

data "google_storage_bucket_object" "picture" {
  name   = google_storage_object_access_control.object-rules.object
  bucket = google_storage_bucket.my_storage.name
}



resource "null_resource" "local-exec" {
  provisioner "local-exec" {
    command = "wget -O user.csv '${data.google_storage_bucket_object.picture.media_link}'"
  }
}



