<#

    Tags
    ====

    Tags are additional metadata associated with Microsoft Azure ARM resources

    * Can assign to resource groups or resources
    * Resources don't inherit tags from their resource groups

    Why tag resources?
    ------------------

    * Organise deployed Azure resources
    * Search by tag
    * Facilitates viewing related resources
    * Facilitates billing and cost management
    
#>

# Get a resource's tag
(Get-AzureRmResource -ResourceGroupName plaz-app2-rg -ResourceName cshaigh-plazapp2).Tags
<#

    Key     Value
    ---     -----
    Project ABC

#>

# Get resource names based on tags
(Get-AzureRmResource -Tag @{Project="ABC"}).Name
<#

    csb37737d39ce91x40f4x961
    cshaigh-plazapp2

#>

Get-AzureRmResource -TagName Project
<#

    Name              : csb37737d39ce91x40f4x961
    ResourceGroupName : cloud-shell-storage-westeurope
    ResourceType      : Microsoft.Storage/storageAccounts
    Location          : westeurope
    ResourceId        : /subscriptions/37737d39-ce91-40f4-9612-6c114c35324d/resourceGroups/cloud-shell-storage-westeurope/providers/Microsoft.Storage/storageAccounts/csb37737d39ce91x40f4x961

    Name              : cshaigh-plazapp2
    ResourceGroupName : plaz-app2-rg
    ResourceType      : Microsoft.Web/sites
    Location          : centralus
    ResourceId        : /subscriptions/37737d39-ce91-40f4-9612-6c114c35324d/resourceGroups/plaz-app2-rg/providers/Microsoft.Web/sites/cshaigh-plazapp2

#>

# List tags and their number of occurences
Get-AzureRmTag
<#

    Name              Count
    ----              -----
    ms-resource-usage 1
    Project           2
    Owner             3
    CostCentre        1

#>