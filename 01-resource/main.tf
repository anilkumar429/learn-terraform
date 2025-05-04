provider "azurerm" {
  features {}
  subscription_id = "7d58fd8a-e8be-4f50-b9f6-03616700d9fc"
}


resource "azurerm_virtual_machine" "test" {
  name                  = "test-vm"
  location              = "UK West"
  resource_group_name   = "project-1"
  network_interface_ids = ["/subscriptions/7d58fd8a-e8be-4f50-b9f6-03616700d9fc/resourceGroups/project-1/providers/Microsoft.Network/networkInterfaces/terraform-testing"]
  # need to create network interface id manually in Azure and provide here
  vm_size               = "Standard_B2s"

  delete_os_disk_on_termination = true

  storage_image_reference {
    id = "/subscriptions/7d58fd8a-e8be-4f50-b9f6-03616700d9fc/resourceGroups/project-1/providers/Microsoft.Compute/images/local-devops-practice"
  }
  storage_os_disk {
    name              = "test-vm-disk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "test-vm"
    admin_username = "azuser"
    admin_password = "Devops@12345"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
}
