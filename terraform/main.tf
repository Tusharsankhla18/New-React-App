provider "azurerm" {
  features {}
  subscription_id = "05cfdc59-160b-424e-ae5f-e8a268bbc516"
}

# Resource Group
resource "azurerm_resource_group" "react_rg" {
  name     = "tushar-react-resource"
  location = "East US 2"
}

# App Service Plan
resource "azurerm_app_service_plan" "react_plan" {
  name                = "react-app-plan"
  location            = "East US 2"
  resource_group_name = azurerm_resource_group.react_rg.name
  kind                = "Linux"
  reserved            = true  # Required for Linux plans

  sku {
    tier = "Basic"
    size = "B1"
  }
}

# App Service (Web App)
resource "azurerm_app_service" "react_app" {
  name                = "tushar-react-frontend-app"
  location            = "East US 2"
  resource_group_name = azurerm_resource_group.react_rg.name
  app_service_plan_id = azurerm_app_service_plan.react_plan.id

  site_config {
    linux_fx_version = "NODE|18-lts"
  }

  app_settings = {
    "WEBSITES_ENABLE_APP_SERVICE_STORAGE" = "false"
    "WEBSITE_NODE_DEFAULT_VERSION"        = "18.15.0"
  }

  https_only = true
}
