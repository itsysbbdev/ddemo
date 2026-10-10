import {
  to = azurerm_resource_group.rg
  id = "/subscriptions/dfbe2d24-6ec8-49a9-9beb-e3a1314f2cc4/resourceGroups/anitacuki"
}

import {
  to = azurerm_virtual_network.vnet
  id = "/subscriptions/dfbe2d24-6ec8-49a9-9beb-e3a1314f2cc4/resourceGroups/anitacuki/providers/Microsoft.Network/virtualNetworks/anitacuki-vmVNET"
}

import {
  to = azurerm_network_security_group.nsg
  id = "/subscriptions/dfbe2d24-6ec8-49a9-9beb-e3a1314f2cc4/resourceGroups/anitacuki/providers/Microsoft.Network/networkSecurityGroups/anitacuki-nsg"
}

import {
  to = azurerm_public_ip.pip
  id = "/subscriptions/dfbe2d24-6ec8-49a9-9beb-e3a1314f2cc4/resourceGroups/anitacuki/providers/Microsoft.Network/publicIPAddresses/anitacuki-pip"
}

import {
  to = azurerm_network_interface.nic
  id = "/subscriptions/dfbe2d24-6ec8-49a9-9beb-e3a1314f2cc4/resourceGroups/anitacuki/providers/Microsoft.Network/networkInterfaces/anitacuki-vmVMNic"
}

import {
  to = azurerm_linux_virtual_machine.vm
  id = "/subscriptions/dfbe2d24-6ec8-49a9-9beb-e3a1314f2cc4/resourceGroups/anitacuki/providers/Microsoft.Compute/virtualMachines/anitacuki-vm"
}
