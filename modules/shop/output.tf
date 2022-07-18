# object media link 
output "csv_data_url" {
  value = data.google_storage_bucket_object.picture.media_link
}

