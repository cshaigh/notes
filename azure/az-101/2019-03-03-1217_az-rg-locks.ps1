<#

    Resouce Groups Locks
    ====================

    * Prevent accidental deletion or changes to resources in resource groups
    * Consists of two locks: -
        1. CanNotDelete
        2. ReadOnly

#>

# Lock plaz-prod1-rg resource group with CanNotDelete lock
New-AzureRmResourceLock -LockName prod1NoDelete -LockLevel CanNotDelete -ResourceGroupName plaz-prod1-rg -Force
<#

    Name              : prod1NoDelete
    ResourceId        : /subscriptions/37737d39-ce91-40f4-9612-6c114c35324d/resourceGroups/plaz-prod1-rg/providers/Microsoft.Authorization/locks/prod1NoDeleteResourceName      : prod1NoDelete
    ResourceType      : Microsoft.Authorization/locks
    ResourceGroupName : plaz-prod1-rg
    SubscriptionId    : 37737d39-ce91-40f4-9612-6c114c35324d
    Properties        : @{level=CanNotDelete}
    LockId            : /subscriptions/37737d39-ce91-40f4-9612-6c114c35324d/resourceGroups/plaz-prod1-rg/providers/Microsoft.Authorization/locks/prod1NoDelete

#>

# Get current locks
Get-AzureRmResourceLock -ResourceGroupName plaz-prod1-rg
<#

    Name              : prod1NoDelete
    ResourceId        : /subscriptions/37737d39-ce91-40f4-9612-6c114c35324d/resourceGroups/plaz-prod1-rg/providers/Microsoft.Authorization/locks/prod1NoDelete
    ResourceName      : prod1NoDelete
    ResourceType      : Microsoft.Authorization/locks
    ResourceGroupName : plaz-prod1-rg
    SubscriptionId    : 37737d39-ce91-40f4-9612-6c114c35324d
    Properties        : @{level=CanNotDelete}
    LockId            : /subscriptions/37737d39-ce91-40f4-9612-6c114c35324d/resourceGroups/plaz-prod1-rg/providers/Microsoft.Authorization/locks/prod1NoDelete

#>

# Create lock in Azure CLI
az lock create --name Lockapp1 --lock-type ReadOnly --resource-group plaz-app1-rg
<#

    {
        "id": "/subscriptions/37737d39-ce91-40f4-9612-6c114c35324d/resourceGroups/plaz-app1-rg/providers/Microsoft.Authorization/locks/Lockapp1",
        "level": "ReadOnly",
        "name": "Lockapp1",
        "notes": null,
        "owners": null,
        "resourceGroup": "plaz-app1-rg",
        "type": "Microsoft.Authorization/locks"
    }

#>

# Remove lock
# Assign lock ID to variable and evaluate
$lockId = (Get-AzureRmResourceLock -ResourceGroupName plaz-prod1-rg).LockId
$lockId
<#

    /subscriptions/37737d39-ce91-40f4-9612-6c114c35324d/resourceGroups/plaz-prod1-rg/providers/Microsoft.Authorization/locks/prod1NoDelete

#>

# Remove lock based on its ID
Remove-AzureRmResourceLock -LockId $lockId -Force
<#

    True

#>

# Verify lock has been deleted
Get-AzureRmResourceLock -ResourceGroupName plaz-prod1-rg
