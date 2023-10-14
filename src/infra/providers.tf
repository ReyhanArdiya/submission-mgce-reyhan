terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.1.0"
    }
  }
}

provider "google" {
  project = ""
  region  = "asia-southeast2"
  zone    = "asia-southeast2-a"
}
