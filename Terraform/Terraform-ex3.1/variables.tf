variable "resource_group_name" {
  type        = string
  description = "The name of the resource group"
}

variable "resource_group_location" {
  type        = string
  description = "The location of the resource group"
}
variable "app_service_plan_name" {
  type        = string
  description = "The name of the service plan"
}
variable "app_service_name" {
  type        = string
  description = "The name of the app"
}
variable "sqlserver_name" {
  type        = string
  description = "The name of the sql server"
}
variable "sql_db_name" {
  type        = string
  description = "The name of the db"
}
variable "sql_admin_login" {
  type        = string
  description = "SQL admin username"
}
variable "sql_admin_password" {
  type        = string
  description = "The password of SQL"
}
variable "firewall_rule_name" {
  type        = string
  description = "Firewall name"
}
variable "repo_url" {
  type        = string
  description = "The git repo"
}