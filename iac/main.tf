terraform {
  backend "azurerm" {

  }
}

locals {
  target_resource_group = format("rg-%s-%s-%s-%s-%03d", var.purpose, var.environment, var.cohort, var.cloudid, var.instance_id)
}

resource "azurerm_resource_group" "target" {
  name     = local.target_resource_group
  location = var.location
  tags = {
    cohort      = var.cohort
    pod         = var.pod
    user        = var.cloudid
    environment = var.environment
    purpose     = var.purpose
  }
}

module "storage_account" {
  source                = "./module"
  cohortid              = format("ce0%s", var.cohort)
  pod                   = var.pod
  cloudid               = var.cloudid
  prefix                = ""
  environment           = var.environment
  target_resource_group = azurerm_resource_group.target.name
  user_write_access     = true

  depends_on = [
    azurerm_resource_group.target
  ]
}



