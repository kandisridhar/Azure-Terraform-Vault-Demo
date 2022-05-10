variable "path" { default = "../vault-admin-workspace/terraform.tfstate" }

terraform {
  backend "local" {
    path = "terraform.tfstate"
  }
}

data "terraform_remote_state" "admin" {
  backend = "local"

  config = {
    path = var.path
  }
}
data "vault_azure_access_credentials" "creds" {
  role                        = data.terraform_remote_state.admin.outputs.role
  backend                     = data.terraform_remote_state.admin.outputs.backend
  # role                        = "admin"
  # backend                     = "azure"
  validate_creds              = true
  num_sequential_successes    = 8
  num_seconds_between_tests   = 1
  max_cred_validation_seconds = 300 
}

provider "azurerm" {
  subscription_id         = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
  tenant_id               = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"

  client_id     = data.vault_azure_access_credentials.creds.client_id
  client_secret = data.vault_azure_access_credentials.creds.client_secret

  features { }
}

provider "vault" {
  address = "http://127.0.0.1:8200"
  token = "hvs.SIlPrzvX70jckfJN22YAiydx"  
}