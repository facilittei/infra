terraform {
  backend "azurerm" {
    storage_account_name = "facilittei"
    container_name       = "infra"
    key                  = "facilitei.terraform.tfstate"
  }
}
