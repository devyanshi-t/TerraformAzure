


# this is a code which creates a new security rule in case of disaster to recover the content of the database subnet.
$ResourceGroupName="testResourcegroup" # Add your own resource group accordingly
$customport=3308 # add your own custom port

$rule1="DisasterRecoveryRule1"
$rule2="DisasterRecoveryRule2"

$nsgname1="databaseterra1" #Change the Name according to need
$nsgname2="databaseterra2"

$resource = Get-AzResource | Where {$_.ResourceGroupName –eq $ResourceGroupName -and $_.ResourceType -eq "Microsoft.Network/networkSecurityGroups"}
$nsg1 = Get-AzNetworkSecurityGroup -Name $nsgname1 -ResourceGroupName $ResourceGroupName
$nsg2 = Get-AzNetworkSecurityGroup -Name $nsgname2 -ResourceGroupName $ResourceGroupName

# Add the inbound security rule.
$nsg2 | Add-AzNetworkSecurityRuleConfig -Name $rule1 -Description "Allow Inbound Coomunication from databse subnet 2 to to database subnet 1" -Access Allow `
-Protocol * -Direction Inbound -Priority 3000 -SourceAddressPrefix "20.0.4.0/24" -SourcePortRange $customport `
-DestinationAddressPrefix "10.0.4.0/24" -DestinationPortRange $customport


# Add the outbound security rule.
$nsg1 | Add-AzNetworkSecurityRuleConfig -Name $rule2 -Description "Allow otbound Communication from databse subnet 2 to to database subnet 1" -Access Allow `
-Protocol * -Direction Outbound -Priority 3000 -SourceAddressPrefix "10.0.4.0/24" -SourcePortRange $customport `
-DestinationAddressPrefix "20.0.4.0/24" -DestinationPortRange $customport

# Update the NSG.
$nsg1 | Set-AzNetworkSecurityGroup
$nsg2 | Set-AzNetworkSecurityGroup















