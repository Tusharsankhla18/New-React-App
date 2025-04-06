output "resource_group_name" {
  description = "Name of the resource group"
  value       = azurerm_resource_group.react_rg.name
}

output "app_service_plan_name" {
  description = "Name of the App Service Plan"
  value       = azurerm_app_service_plan.react_plan.name
}

output "app_service_default_hostname" {
  description = "Default hostname for the deployed React app"
  value       = azurerm_app_service.react_app.default_site_hostname
}

output "app_service_url" {
  description = "Fully qualified domain name (URL) of the React app"
  value       = "https://${azurerm_app_service.react_app.default_site_hostname}"
}
