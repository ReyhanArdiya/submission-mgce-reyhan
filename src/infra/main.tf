# TODO Give viewer access to GCS and maybe GCE for reviewer team

module "money-tracker-bucket-main" {
  source = "./gcs"
  name   = "money-tracker-bucket-2947582"
}

resource "google_storage_bucket" "terraform-state-mgce-mreyhanapw" {
  name     = "terraform-state-mgce-mreyhanapw"
  location = "ASIA-SOUTHEAST2"
}


module "money-tracker-db" {
  source = "./csql"
}
