terraform {
  required_providers {
    vultr = {
      source  = "vultr/vultr"
      version = "2.1.3"
    }
  }
}

provider "vultr" {}

resource "vultr_instance" "api" {
  plan     = "vc2-1c-1gb"
  region   = var.region
  os_id    = "387"
  label    = "${var.environment}-api"
  hostname = var.hostname
  tag      = var.environment
}
