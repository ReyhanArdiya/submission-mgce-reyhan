resource "google_service_account" "money-tracker-fe" {
  account_id   = "money-tracker-fe"
  display_name = "money-tracker-fe"
}

resource "google_storage_bucket" "default" {
  name                        = var.name
  location                    = var.gcs_location
  uniform_bucket_level_access = true

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

resource "google_storage_bucket_iam_policy" "money-tracker-fe-upload" {
  bucket = google_storage_bucket.default.name
  policy_data = jsonencode({
    bindings = [
      {
        role = "roles/storage.objectCreator"
        members = [
          "serviceAccount:${google_service_account.money-tracker-fe.email}"
        ]
      }
    ]
  })
}
