resource "google_storage_bucket" "default" {
  name     = var.name
  location = var.gcs_location

  lifecycle_rule {
    condition {
      age = 30
    }
    action {
      storage_class = "NEARLINE"
      type          = "SetStorageClass"
    }
  }
}
