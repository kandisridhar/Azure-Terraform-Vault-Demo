terraform {
  required_providers {
    vault = {
      source  = "hashicorp/vault"
      version = "2.15.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.36.0"
    }
  }
}

provider "vault" {
  address = "http://127.0.0.1:8200"
  token = "hvs.SIlPrzvX70jckfJN22YAiydx"
}

provider "azurerm" {
    features {
    
  }
}
