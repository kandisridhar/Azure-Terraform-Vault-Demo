terraform {
  backend "local" {
    path = "terraform.tfstate"
  }
}

resource "azurerm_resource_group" "vault-rg" {
  name = "azure-vault-group"
  location = "eastasia"
}

resource "vault_azure_secret_backend" "azure" {
 # use_microsoft_graph_api = true
  subscription_id         = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
  tenant_id               = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
  client_id               = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
  client_secret           = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
  //environment             = "AzurePublicCloud"  
}
resource "vault_azure_secret_backend_role" "admin" {
  backend                     = vault_azure_secret_backend.azure.path
  role                        = "admin"
  ttl                         = 300
  max_ttl                     = 600

  azure_roles {
    role_name = "Contributor"
    scope =  "/subscriptions/e306c6bc-988a-4bc0-8bd7-9c88a95ec882/resourceGroups/azure-vault-group"
  }
}

output "backend" {
  value = vault_azure_secret_backend.azure.path
}

output "role" {
  value = vault_azure_secret_backend_role.admin.role
}
