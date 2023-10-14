terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.1.0"
    }
  }

  backend "gcs" {
    bucket = "terraform-state-mgce-mreyhanapw"
    prefix = "terraform/state"
  }
}

provider "google" {
  project = "submission-mgce-mreyhanapw"
  region  = "asia-southeast2"
  zone    = "asia-southeast2-a"
}
