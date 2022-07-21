module "shop_database" {
  source      = "./modules/shop"
  bucket_name = var.bucket_name
  location    = "US"
  source_path = "shop_data.csv"
  source_name = " shop_data"
  role        = var.roles
  entity      = var.entity
  jobloadid   = var.jobid
}










