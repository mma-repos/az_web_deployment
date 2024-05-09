variable "target_resource_group" {
  type        = string
  description = "The azure resource group where this storage account & container will be deployed"
}

variable "cloudid" {
  type        = string
  description = "Cloud ID of the user"
}

variable "environment" {
  type        = string
  description = "Cohortid Environment Identifier"
}

variable "prefix" {
  type        = string
  description = "prefix for the site name"
}

variable "pod" {
  type        = string
  description = "Pod Name"
}

variable "cohortid" {
  type        = string
  description = "ID of the cohort"
}

variable "user_write_access" {
  type        = bool
  description = "Allows user to access the storage container directly"
}


