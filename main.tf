terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=4.1.0"
    }
  }
}
provider "azurerm" {
  features {}
}

terraform {
  backend "azurerm" {
    resource_group_name  = "pgrabowski-workshop" #change here
    storage_account_name = "pgrabowskiworkshop" #change here
    container_name       = "tfstate" #change here
    key                  = "terraform.tfstate"
  }
}

resource "azurerm_service_plan" "example" {
  name                = "pgrabowski-workshop-plan" #change here
  location            = "eastus2" #change here
  resource_group_name = "pgrabowski-workshop" #change here
  os_type             = "Linux"
  sku_name            = "P0v3"
}

resource "azurerm_linux_web_app" "example" {
  name                = "pgrabowski-workshop-webapp" #change here
  location            = "eastus2" #change here
  resource_group_name = "pgrabowski-workshop" #change here
  service_plan_id     = azurerm_service_plan.example.id
  site_config {}
}
