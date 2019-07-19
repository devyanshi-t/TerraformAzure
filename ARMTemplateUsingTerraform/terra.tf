
resource "azurerm_resource_group" "test" {
  name     = "myResourceGroup"
  location = "East US"


}

resource "azurerm_template_deployment" "test" {
  name                = "Main-Deploy-2"
  resource_group_name = "${azurerm_resource_group.test.name}"

  template_body = "${file("./master.json")}"

  parameters={
      "Vnet1name"="virtualnetwork1"
      "location"="westus",
      "VnetaddressPrefix"="10.0.0.0/16",
      "subnetName1"="S1",
       "subnetName2"="S2",
      "subnetName3"="S3",
       "firewallSubnetAddressPrefix"="10.0.1.0/24",
      "subnetAddressPrefix1"="10.0.2.0/24",
      "subnetAddressPrefix2"="10.0.3.0/24",
      "subnetAddressPrefix3"="10.0.4.0/24",
      "SecondVnetname"="virtualnetwork2"
       "Secondlocation"="eastus",
      "SecondVnetaddressPrefix"="20.0.0.0/16",
      "SecondVnetsubnetName1"="S21",
      "SecondVnetsubnetName2"="S22",
       "SecondVnetsubnetName3"="S23",
       "SecondVnetsubnetAddressPrefix1"="20.0.2.0/24",
        "SecondVnetsubnetAddressPrefix2"="20.0.3.0/24",
         "SecondVnetsubnetAddressPrefix3"="20.0.4.0/24",
          "SecondVnetfirewallSubnetAddressPrefix"="20.0.1.0/24",
           "Web_NSGName"="WEB1",
             "Api_NSGName"="AP1",
             "Db_NSGName"="DB1",
             "Web1_NSGName"="WEB2",
             "Api1_NSGName"="AP2",
              "Db1_NSGName"="DB2",
      "enableDdosProtection"=null,
     "virtualNetworkAccess"=null,
      "forwardedTraffic"=null,
      "gatewayTransit"=null,
      "remoteGateways"=null

  }
  deployment_mode="Incremental"

}

