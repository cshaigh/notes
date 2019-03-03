<#

    Moving Resources
    ================

    * Not all resources can be moved
    * Can move resources to a resource group in a different location
    * Can create the new resource group at the same time as the move

    Moving Resources with Powershell and CLI
    ----------------------------------------

    * Create a variable $resource
    * Move-AzureRmResource
    * az resource move

#>

# Get VNet1, assign to variable and evaluate
$resource = Get-AzureRmResource -ResourceGroupName plaz-net2-rg -ResourceName VNet1
$resource
<#

    Name              : VNet1
    ResourceGroupName : plaz-net2-rg
    ResourceType      : Microsoft.Network/virtualNetworks
    Location          : eastus
    ResourceId        : /subscriptions/37737d39-ce91-40f4-9612-6c114c35324d/resourceGroups/plaz-net2-rg/providers/Microsoft.Network/virtualNetworks/VNet1

#>

# Move resource back into plaz-net-rg resource group (warning: takes AGES [several minutes])
Move-AzureRmResource -ResourceId $resource.ResourceId -DestinationResourceGroupName plaz-net-rg -Force

# Assign resourceId of VNet1 in plaz-net-rg to variable and evaluate
resourceId=$(az resource show --resource-group plaz-net-rg --name vnet1 --resource-type Microsoft.Network/virtualNetworks --query id --output tsv)
echo $resourceId
<#

    /subscriptions/37737d39-ce91-40f4-9612-6c114c35324d/resourceGroups/plaz-net-rg/providers/Microsoft.Network/virtualNetworks/VNet1

#>

# Move VNet1 to plaz-net2-rg
az resource move --id $resourceId --destination-group plaz-net2-rg
