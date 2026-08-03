resource "azurerm_linux_virtual_machine" "vms" {
  for_each                        = var.vms
  name                            = each.value.name
  location                        = each.value.location
  resource_group_name             = each.value.resource_group_name
  size                            = each.value.size
  admin_username                  = each.value.admin_username
  admin_password                  = each.value.admin_password
  disable_password_authentication = false
  network_interface_ids           = [data.azurerm_network_interface.nic[each.key].id]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = lookup(each.value, "storage_account_type", "Standard_LRS")
  }

  source_image_reference {
    publisher = lookup(each.value, "publisher", "Canonical")
    offer     = lookup(each.value, "offer", "0001-com-ubuntu-server-jammy")
    sku       = lookup(each.value, "sku", "22_04-lts")
    version   = lookup(each.value, "version", "latest")
  }
}
