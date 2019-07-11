resource "azurerm_resource_group" "tera" {
  name= "myResourceGroup"
  location="East US"
}

resource "azurerm_network_security_group" "nsg1" {
  name                = "webterra1"
  location            = "East US"
  resource_group_name = "${azurerm_resource_group.tera.name}"
}

resource "azurerm_network_security_group" "nsg2" {
  name                = "Apiterra1"
  location            = "East US"
  resource_group_name = "${azurerm_resource_group.tera.name}"
}
resource "azurerm_network_security_group" "nsg3" {
  name                = "datbaseterra1"
  location            = "East US"
  resource_group_name = "${azurerm_resource_group.tera.name}"
}

resource "azurerm_network_security_group" "nsg4" {
  name                = "Webterra2"
  location            = "West US"
  resource_group_name = "${azurerm_resource_group.tera.name}"
}
resource "azurerm_network_security_group" "nsg5" {
  name                = "Apiterra2"
  location            = "West US"
  resource_group_name = "${azurerm_resource_group.tera.name}"
}
resource "azurerm_network_security_group" "nsg6" {
  name                = "databaseterra2"
  location            = "West US"
  resource_group_name = "${azurerm_resource_group.tera.name}"
}

resource "azurerm_network_security_rule" "ruleweb1" {
  name= "HTTPorHTTPS"
  network_security_group_name ="${azurerm_network_security_group.nsg1.name}"
  direction= "Inbound"   

  access= "Allow"
  priority= 100
  source_address_prefix = "*"
  source_port_range = "*"
  destination_address_prefix= "30.0.0.0/24"
  destination_port_ranges = ["80","443"]
  protocol = "Tcp"
  resource_group_name= "${azurerm_resource_group.tera.name}"
}
resource "azurerm_network_security_rule" "ruleweb2" {
  name= "HTTPorHTTPS"
  network_security_group_name = "${azurerm_network_security_group.nsg4.name}"
  direction= "Inbound"   

  access= "Allow"
  priority= 100
  source_address_prefix = "*"
  source_port_range = "*"
  destination_address_prefix= "40.0.0.0/24"
  destination_port_ranges = ["80","443"]
  protocol = "Tcp"
  resource_group_name= "${azurerm_resource_group.tera.name}"
}

resource "azurerm_network_security_rule" "rulewebtodb1" {
    name = "DenyConnectionToDatabase"
            

  protocol = "Tcp"
  source_port_range = "*"
  destination_port_range = "*"
  source_address_prefix = "*"
  destination_address_prefix= "30.0.2.0/24"
  access= "Deny"
  priority= 100
  direction= "Outbound"
   resource_group_name= "${azurerm_resource_group.tera.name}"
  network_security_group_name = "${azurerm_network_security_group.nsg1.name}"


}
resource "azurerm_network_security_rule" "rulewebtodb2" {
    name = "DenyConnectionToDatabase"
            

  protocol = "Tcp"
  source_port_range = "*"
  destination_port_range = "*"
  source_address_prefix = "*"
  destination_address_prefix= "40.0.2.0/24"
  access= "Deny"
  priority= 100
  direction= "Outbound"
   resource_group_name= "${azurerm_resource_group.tera.name}"
  network_security_group_name = "${azurerm_network_security_group.nsg4.name}"


}
resource "azurerm_network_security_rule" "webtoapi1" {
   name = "WEBtoAPI"
          

  protocol = "Tcp"
  source_port_range = "*"
  destination_port_ranges = ["81","445"]
  source_address_prefix= "30.0.0.0/24"
  destination_address_prefix= "30.0.1.0/24"
  access= "Allow"
  priority= 110
  direction= "Outbound"
  
  network_security_group_name = "${azurerm_network_security_group.nsg1.name}"
  resource_group_name= "${azurerm_resource_group.tera.name}"
}
resource "azurerm_network_security_rule" "webtoapi2" {
   name = "WEBtoAPI"
          

  protocol = "Tcp"
  source_port_range = "*"
  destination_port_ranges = ["81","445"]
  source_address_prefix ="40.0.0.0/24"
  destination_address_prefix="40.0.1.0/24"
  access= "Allow"
  priority= 110
  direction= "Outbound"
  
  network_security_group_name = "${azurerm_network_security_group.nsg4.name}"
  resource_group_name= "${azurerm_resource_group.tera.name}"
}
resource "azurerm_network_security_rule" "api1" {
   name= "HTTPfromWEB"
            

  protocol = "Tcp"
  source_port_range = "*"
  destination_port_ranges = ["80","443"]
  source_address_prefix = "30.0.0.0/24"
  destination_address_prefix= "30.0.1.0/24"
  access= "Allow"
  priority= 100
  direction= "Inbound"
 
  network_security_group_name ="${azurerm_network_security_group.nsg2.name}"
  resource_group_name= "${azurerm_resource_group.tera.name}"
}
resource "azurerm_network_security_rule" "api2" {
   name= "HTTPfromWEB"
            

  protocol = "Tcp"
  source_port_range = "*"
  destination_port_ranges = ["80","443"]
  source_address_prefix="40.0.0.0/24"
  destination_address_prefix="40.0.1.0/24"
  access= "Allow"
  priority= 100
  direction= "Inbound"
 
  network_security_group_name = "${azurerm_network_security_group.nsg5.name}"
  resource_group_name= "${azurerm_resource_group.tera.name}"
}
resource "azurerm_network_security_rule" "dbtoapi1" {
   name= "DATABASEtoAPI"
            

  protocol = "Tcp"
  source_port_ranges = ["80","443"]
  destination_port_ranges = ["81","445"]
  source_address_prefix = "30.0.2.0/24"
  destination_address_prefix= "30.0.1.0/24"
  access= "Allow"
  priority= 110
  direction= "Inbound"
  
  network_security_group_name = "${azurerm_network_security_group.nsg2.name}"
  resource_group_name= "${azurerm_resource_group.tera.name}"
}
resource "azurerm_network_security_rule" "dbtoapi2" {
   name= "DATABASEtoAPI"
            

  protocol = "Tcp"
  source_port_ranges = ["80","443"]
  destination_port_ranges = ["81","445"]
  source_address_prefix = "40.0.2.0/24"
  destination_address_prefix="40.0.1.0/24"
  access= "Allow"
  priority= 110
  direction= "Inbound"
  
  network_security_group_name = "${azurerm_network_security_group.nsg5.name}"
  resource_group_name= "${azurerm_resource_group.tera.name}"
}
resource "azurerm_network_security_rule" "apitodb1" {
   name= "APItoDATABASE"
  protocol = "Tcp"
  source_port_range ="*"
  destination_port_range = "3306"
  source_address_prefix="30.0.1.0/24"
  destination_address_prefix="30.0.2.0/24"
  access= "Allow"
  priority= 100
  direction= "Outbound"
  network_security_group_name = "${azurerm_network_security_group.nsg5.name}"
  resource_group_name= "${azurerm_resource_group.tera.name}"
}
resource "azurerm_network_security_rule" "apitodb2" {
   name= "APItoDATABASE"
            

  protocol = "Tcp"
  source_port_range ="*"
  destination_port_range = "3306"
  source_address_prefix="40.0.1.0/24"
  destination_address_prefix="40.0.2.0/24"
  access= "Allow"
  priority= 100
  direction= "Outbound"
  network_security_group_name = "${azurerm_network_security_group.nsg2.name}"
  resource_group_name= "${azurerm_resource_group.tera.name}"
}
resource "azurerm_network_security_rule" "apitoweb1" {
   name= "APItoWEB"
            

  protocol = "Tcp"
  source_port_range = "*"
  destination_port_ranges = ["82","446"]
  source_address_prefix="30.0.1.0/24"
  destination_address_prefix="30.0.0.0/24"
  access= "Allow"
  priority= 110
  direction= "Outbound"
  network_security_group_name = "${azurerm_network_security_group.nsg2.name}"
  resource_group_name= "${azurerm_resource_group.tera.name}"
}
resource "azurerm_network_security_rule" "apitoweb2" {
   name= "APItoWEB"
            

  protocol = "Tcp"
  source_port_range = "*"
  destination_port_ranges = ["82","446"]
  source_address_prefix="40.0.1.0/24"
  destination_address_prefix="40.0.0.0/24"
  access= "Allow"
  priority= 110
  direction= "Outbound"
  network_security_group_name = "${azurerm_network_security_group.nsg5.name}"
  resource_group_name= "${azurerm_resource_group.tera.name}"
}
resource "azurerm_network_security_rule" "apitiodb1" {
   name= "ApitoDBI"
            

  protocol = "Tcp"
  source_port_range ="*"
  destination_port_range = "3306"
  source_address_prefix="30.0.1.0/24"
  destination_address_prefix="30.0.2.0/24"
  access= "Allow"
  priority= 100
  direction= "Inbound"
  network_security_group_name ="${azurerm_network_security_group.nsg3.name}"
  resource_group_name="${azurerm_resource_group.tera.name}"
}
resource "azurerm_network_security_rule" "apidb2" {
   name= "ApitoDB"
            

  protocol = "Tcp"
  source_port_range ="*"
  destination_port_range = "3306"
  source_address_prefix="40.0.1.0/24"
  destination_address_prefix="40.0.2.0/24"
  access= "Allow"
  priority= 100
  direction= "Inbound"
  network_security_group_name ="${azurerm_network_security_group.nsg6.name}"
  resource_group_name="${azurerm_resource_group.tera.name}"
}
resource "azurerm_network_security_rule" "webtodb1" {
   name= "WEBtoDB"
            

  protocol = "Tcp"
  source_port_range ="*"
  destination_port_range = "*"
  source_address_prefix = "30.0.0.0/24"
  destination_address_prefix= "30.0.2.0/24"
  access= "Deny"
  priority= 110
  direction= "Inbound"
  network_security_group_name ="${azurerm_network_security_group.nsg6.name}"
  resource_group_name="${azurerm_resource_group.tera.name}"
}
resource "azurerm_network_security_rule" "webtodb2" {
   name= "WEBtoDB"
            

  protocol = "Tcp"
  source_port_range ="*"
  destination_port_range = "*"
  source_address_prefix = "40.0.0.0/24"
  destination_address_prefix="40.0.2.0/24"
  access= "Deny"
  priority= 110
  direction= "Inbound"
  network_security_group_name ="${azurerm_network_security_group.nsg3.name}"
  resource_group_name="${azurerm_resource_group.tera.name}"
}
resource "azurerm_network_security_rule" "SSH1" {
   name= "SSH"
            

  protocol = "Tcp"
  source_port_range ="*"
  destination_port_range = "22"
  source_address_prefix="30.0.2.0/24"
  destination_address_prefix= "30.0.2.0/24"
  access= "Allow"
  priority= 120
  direction= "Inbound"
  network_security_group_name ="${azurerm_network_security_group.nsg6.name}"
  resource_group_name="${azurerm_resource_group.tera.name}"
}
resource "azurerm_network_security_rule" "SSH2" {
   name= "SSH"
            

  protocol = "Tcp"
  source_port_range ="*"
  destination_port_range = "22"
  source_address_prefix="40.0.2.0/24"
  destination_address_prefix="40.0.2.0/24"
  access= "Allow"
  priority= 120
  direction= "Inbound"
  network_security_group_name ="${azurerm_network_security_group.nsg3.name}"
  resource_group_name="${azurerm_resource_group.tera.name}"
}

resource "azurerm_network_security_rule" "dbapiout1" {
   name= "DATABASEToAPI"
            

  protocol = "Tcp"
  source_port_range ="*"
  destination_port_ranges = ["81","445"]
  source_address_prefix="30.0.2.0/24"
  destination_address_prefix="30.0.1.0/24"
  access= "Allow"
  priority= 100
  direction= "Outbound"
  network_security_group_name ="${azurerm_network_security_group.nsg6.name}"
  resource_group_name= "${azurerm_resource_group.tera.name}"
}
resource "azurerm_network_security_rule" "dbapiout2" {
   name= "DATABASEToAPI"
            

  protocol = "Tcp"
  source_port_range ="*"
  destination_port_ranges = ["81","445"]
  source_address_prefix="40.0.2.0/24"
  destination_address_prefix="40.0.1.0/24"
  access= "Allow"
  priority= 100
  direction= "Outbound"
  network_security_group_name ="${azurerm_network_security_group.nsg3.name}"
  resource_group_name= "${azurerm_resource_group.tera.name}"
}





resource "azurerm_virtual_network" "vnet1" {
  name                = "VNetwork1"
  location            = "East US"
  resource_group_name = "${azurerm_resource_group.tera.name}"
  address_space       = ["30.0.0.0/16"]


  subnet {
    name           = "web"
    address_prefix = "30.0.0.0/24"
    security_group="${azurerm_network_security_group.nsg1.id}"
  }
   subnet {
    name           = "api"
    address_prefix = "30.0.1.0/24"
    security_group="${azurerm_network_security_group.nsg2.id}"
  }
   subnet {
    name           = "db"
    address_prefix = "30.0.2.0/24"
    security_group="${azurerm_network_security_group.nsg3.id}"
  }
}

resource "azurerm_virtual_network" "vnet2" {
  name                = "NetworkV2"
  location            = "West US"
  resource_group_name = "${azurerm_resource_group.tera.name}"
  address_space       = ["40.0.0.0/16"]


  subnet {
    name           = "web"
    address_prefix = "40.0.0.0/24"
    security_group="${azurerm_network_security_group.nsg4.id}"
  }
   subnet {
    name           = "api"
    address_prefix = "40.0.1.0/24"
    security_group="${azurerm_network_security_group.nsg5.id}"
  }
   subnet {
    name           = "db"
    address_prefix = "40.0.2.0/24"
    security_group="${azurerm_network_security_group.nsg6.id}"
  }
}

resource "azurerm_virtual_network_peering" "peer1" {
  name                      = "VNetwork1toNetworkV2"
  resource_group_name       = "${azurerm_resource_group.tera.name}"
  virtual_network_name      = "${azurerm_virtual_network.vnet1.name}"
  remote_virtual_network_id = "${azurerm_virtual_network.vnet2.id}"
}

resource "azurerm_virtual_network_peering" "peer2" {
  name                      = "VNetwork2toVNetwork1"
  resource_group_name       = "${azurerm_resource_group.tera.name}"
  virtual_network_name      = "${azurerm_virtual_network.vnet2.name}"
  remote_virtual_network_id = "${azurerm_virtual_network.vnet1.id}"
}
