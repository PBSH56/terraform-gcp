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
  object = google_storage_bucket_object.shop_data_csv.name
  bucket = google_storage_bucket.my_storage.name
  role   = var.role
  entity = var.entity
}

data "google_storage_bucket_object" "picture" {
  name   = google_storage_bucket_object.shop_data_csv.name
  bucket = google_storage_bucket.my_storage.name
}

# resource "null_resource" "local-exec" {
#   provisioner "local-exec" {
#     command = "wget -O email.csv '${data.google_storage_bucket_object.picture.media_link}'"
#   }
# }



