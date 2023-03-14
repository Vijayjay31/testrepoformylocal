terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.44.1"
    }
  }
}

provider "azurerm" {
  features {}
}

#Resource_group_creation
resource "azurerm_resource_group" "Terr-storage" {
    name = "Storage-RG"
    location = "East US"
  
}

resource "azurerm_storage_account" "terr-SR-account" {
    name = "storageaccount6700089"
    resource_group_name = azurerm_resource_group.Terr-storage.name
    location = azurerm_resource_group.Terr-storage.location
    account_tier = "Standard"
    account_replication_type = "LRS"

  
}

resource "azurerm_storage_container" "SR-Blob-container" {
    name = "datafromterra67"
    storage_account_name = azurerm_storage_account.terr-SR-account.name
    container_access_type = "private"
  
}

#storage_queue_creation
resource "azurerm_storage_queue" "SR_queue" {
    name = "queuesrfromterra67"
    storage_account_name = azurerm_storage_account.terr-SR-account.name
  
}

#storage_sharefile_creation
resource "azurerm_storage_share" "SR_sharefile" {
    name = "sharefilesfromterra67"
    storage_account_name = azurerm_storage_account.terr-SR-account.name
    quota = 5
  
}

#Storage_life_cycle_Management_policycls
resource "azurerm_storage_management_policy" "SR_life_cycle" {
    storage_account_id = azurerm_storage_account.terr-SR-account.id

    rule {
    name    = "rule1"
    enabled = true
    filters {
      prefix_match = ["container1/prefix1"]
      blob_types   = ["blockBlob"]
      
    }
    actions {
      base_blob {
        tier_to_cool_after_days_since_modification_greater_than    = 10
        tier_to_archive_after_days_since_modification_greater_than = 50
        delete_after_days_since_modification_greater_than          = 100
      }
      snapshot {
        delete_after_days_since_creation_greater_than = 30
      }
    }

  
}
}