provider "google" {
  credentials = file("key.json")
  project     = "t-12-vm"
  region      = "us-central1"
}