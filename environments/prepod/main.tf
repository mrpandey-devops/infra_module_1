module "rgs" {
  source = "../../modules/azurerm_resource_group"
  rgs    = var.rgs
}

module "vnet" {
  source     = "../../modules/azurerm_virtual_network"
  vnet       = var.vnet
  depends_on = [module.rgs]
}

module "subnet" {
  source     = "../../modules/azurerm_subnet"
  subnet     = var.subnet
  depends_on = [module.vnet]
}

module "pip" {
  source     = "../../modules/azurerm_private_ip"
  pips       = var.pip
  depends_on = [module.rgs]
}

module "nics" {
  source     = "../../modules/azurerm_network_interface"
  nics       = var.nics
  depends_on = [module.pip, module.subnet]
}

module "vms" {
  source     = "../../modules/azurerm_linux_virtual_machine"
  vms        = var.vms
  depends_on = [module.nics]
}
