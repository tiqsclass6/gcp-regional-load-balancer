# https://www.terraform.io/language/settings/backends/gcs

terraform {
  backend "gcs" {
    bucket      = "your-bucket-name" # Insert your bucket name here
    prefix      = "terraform/state"
    credentials = "yourkey.json" # Insert your JSON key here
  }
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"
    }
  }
}

# https://registry.terraform.io/providers/hashicorp/google/latest/docs

provider "google" {
  project     = "your-project-id" # Insert your project ID here
  region      = "us-central1"     # Insert your region here
  credentials = "yourkey.json"    #Insert your JSON key here
}