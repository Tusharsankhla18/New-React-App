provider "azurerm" {
  features {}
  subscription_id = "9e88581e-e755-404d-819f-4d6e468ad176"
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
