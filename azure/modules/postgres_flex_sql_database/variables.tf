# General variables 
variable "environment" {
  description = "The name for identifying the type of environment"
  type        = string
}

variable "location" {
  description = "The data center location where all resources will be put into."
  type        = string
}

variable "common_name_prefix" {
  description = "The prefix used to name all resources created."
  type        = string
}

variable "name" {
  description = "The resoursce name to allocate."
  type        = string
}

variable "tags" {
  type        = map(string)
  description = "Any tags that should be present on the Virtual Network resources"
  default     = {}
}

#Postgres Database Variables
variable "postgres_flex_server_id" {
  description = "The ID of the Azure PostgreSQL Flexible Server from which to create this PostgreSQL Flexible Server Database. Changing this forces a new Azure PostgreSQL Flexible Server Database to be created."
  type        = string
}

variable "charset" {
  description = "Specifies the Charset for the PostgreSQL Database, which needs to be a valid PostgreSQL Charset (https://www.postgresql.org/docs/current/static/multibyte.html). Changing this forces a new resource to be created."
  type        = string
  default     = "UTF8"
}

variable "collation" {
  description = "Specifies the Collation for the PostgreSQL Database, which needs to be a valid PostgreSQL Collation (https://www.postgresql.org/docs/current/static/collation.html). Note that Microsoft uses different notation - en-US instead of en_US. Changing this forces a new resource to be created."
  type        = string
  default     = "en_US"
}