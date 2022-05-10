terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>2.0"
    }
    vault = {
      source  = "hashicorp/vault"
      version = "2.17.0"
    }
  }
}
