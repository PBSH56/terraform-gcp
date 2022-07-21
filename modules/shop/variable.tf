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
