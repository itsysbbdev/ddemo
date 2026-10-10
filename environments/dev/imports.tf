import {
  to = module.networking.azurerm_virtual_network.vnet
  id = "/subscriptions/dfbe2d24-6ec8-49a9-9beb-e3a1314f2cc4/resourceGroups/anitacuki/providers/Microsoft.Network/virtualNetworks/anitacuki-vmVNET"
}

import {
  to = module.networking.azurerm_subnet.subnet
  id = "/subscriptions/dfbe2d24-6ec8-49a9-9beb-e3a1314f2cc4/resourceGroups/anitacuki/providers/Microsoft.Network/virtualNetworks/anitacuki-vmVNET/subnets/anitacuki-vmSubnet"
}

import {
  to = module.networking.azurerm_network_security_group.nsg
  id = "/subscriptions/dfbe2d24-6ec8-49a9-9beb-e3a1314f2cc4/resourceGroups/anitacuki/providers/Microsoft.Network/networkSecurityGroups/anitacuki-nsg"
}

import {
  to = module.compute.azurerm_public_ip.pip
  id = "/subscriptions/dfbe2d24-6ec8-49a9-9beb-e3a1314f2cc4/resourceGroups/anitacuki/providers/Microsoft.Network/publicIPAddresses/anitacuki-pip"
}

import {
  to = module.compute.azurerm_network_interface.nic
  id = "/subscriptions/dfbe2d24-6ec8-49a9-9beb-e3a1314f2cc4/resourceGroups/anitacuki/providers/Microsoft.Network/networkInterfaces/anitacuki-vmVMNic"
}

import {
  to = module.compute.azurerm_network_interface_security_group_association.nsg_assoc
  id = "/subscriptions/dfbe2d24-6ec8-49a9-9beb-e3a1314f2cc4/resourceGroups/anitacuki/providers/Microsoft.Network/networkInterfaces/anitacuki-vmVMNic|/subscriptions/dfbe2d24-6ec8-49a9-9beb-e3a1314f2cc4/resourceGroups/anitacuki/providers/Microsoft.Network/networkSecurityGroups/anitacuki-nsg"
}

import {
  to = module.compute.azurerm_linux_virtual_machine.vm
  id = "/subscriptions/dfbe2d24-6ec8-49a9-9beb-e3a1314f2cc4/resourceGroups/anitacuki/providers/Microsoft.Compute/virtualMachines/anitacuki-vm"
}
