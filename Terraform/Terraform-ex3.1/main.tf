terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.114.0"
    }
  }
}

provider "azurerm" {
  skip_provider_registration = true
  features {}
}

resource "azurerm_resource_group" "arg" {
  name     = "TaskboardRG${random_integer.ri.result}1"
  location = var.resource_group_location
}

resource "random_integer" "ri" {
  min = 10000
  max = 999999
}

resource "azurerm_service_plan" "asplan" {
  name                = "Taskboard_ServicePlan"
  resource_group_name = azurerm_resource_group.arg.name
  location            = azurerm_resource_group.arg.location
  os_type             = "Linux"
  sku_name            = "F1"
}

resource "azurerm_linux_web_app" "cbwa" {
  name                = "TaskboardApp-diyan"
  resource_group_name = azurerm_resource_group.arg.name
  location            = azurerm_resource_group.arg.location
  service_plan_id     = azurerm_service_plan.asplan.id

  site_config {
    application_stack {
      dotnet_version = "6.0"
    }
    always_on = false
  }

  connection_string {
    name  = "DefaultConnection"
    type  = "SQLAzure"
    value = "Data Source=tcp:${azurerm_mssql_server.sqlserver.fully_qualified_domain_name},1433;Initial Catalog=${azurerm_mssql_database.sqldb.name};User ID=${azurerm_mssql_server.sqlserver.administrator_login};Password=${azurerm_mssql_server.sqlserver.administrator_login_password};Trusted_Connection=False; MultipleActiveResultSets=True;"
  }
}

resource "azurerm_app_service_source_control" "sql_taskboard" {
  app_id                 = azurerm_linux_web_app.cbwa.id
  repo_url               = "https://github.com/dimosoftuni/taskboardemoapp"
  branch                 = "main"
  use_manual_integration = true
}

resource "azurerm_mssql_server" "sqlserver" {
  name                         = "mssqlserver-diyan-taskboard"
  resource_group_name          = azurerm_resource_group.arg.name
  location                     = azurerm_resource_group.arg.location
  version                      = "12.0"
  administrator_login          = "missadministrator"
  administrator_login_password = "thisIsKat11"
}

resource "azurerm_mssql_database" "sqldb" {
  name               = "example-db"
  server_id          = azurerm_mssql_server.sqlserver.id
  collation          = "SQL_Latin1_General_CP1_CI_AS"
  license_type       = "LicenseIncluded"
  max_size_gb        = 2
  sku_name           = "S0"
  geo_backup_enabled = false
}

resource "azurerm_mssql_firewall_rule" "firewall" {
  name             = "FirewallRule1"
  server_id        = azurerm_mssql_server.sqlserver.id
  start_ip_address = "0.0.0.0"
  end_ip_address   = "0.0.0.0"
}
