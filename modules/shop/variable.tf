variable "bucket_name" {
  type = string
}

variable "location" {
  type = string
}

variable "source_path" {
  type = string
}

variable "source_name" {
  type = string
}

variable "role" {
  type = string
}

variable "entity" {
  type = string
}

variable "project_id" {
  type = string
  default = "t-12-vm"
}


# bigquery variable

variable "dataset" {
  type = string
  default ="shop45_dataset"
}

variable "table_name" {
  type = string
  default = "shop_data"
}

variable "table_description" {
  type = string
  string = "This table contain sales data of Shop45"
}

variable "jobloadid" {
  type = string
}


variable "user_table" {
  type = string
  default = "user_table"
}

variable "user_data_csv" {
  type = string
  default = "user-data"
}


