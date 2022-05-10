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
  subscription_id         = "e306c6bc-988a-4bc0-8bd7-9c88a95ec882"
  tenant_id               = "e521ac68-af0c-448a-a78c-8f88bffba94a"
  client_id               = "59907920-e580-45a9-b01d-1027c9013107"
  client_secret           = "Fu08Q~plZzhTpJTp2vwEHPSRn9tPChq.ub2ORc37"
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
