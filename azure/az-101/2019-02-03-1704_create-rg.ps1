<#

    Resource Group

    Name: plaz-net-rg
    Need: Prevent unwanted changes to any of the network resources
    Admin: IT will deploy and maintain RG
    Notes: Resources in other RGs will use the resources in this group
    Dept: IT
    Owner: Inhoff Behili

#>



<#

    Resource Group

    Name: plaz-prod1-rg
    Purpose: Contain the company's VM and their associated dependent resources
    Need: Prevent the accidental deletion of any service or VM
    Admin: IT group will deploy and maintain VMs for the company
    Notes: Resources only in East US location
    Dept: IT
    Owner: Susan Berlin

#>

New-AzureRmResourceGroup -Name 'plaz-prod1-rg' -Location 'West US'

<#

    Resource Group

    Name: plaz-dev-rg
    Purpose: Isolate the resources that are used for development and research
    Need: Flexibility, since many resources will be created and deleted
    Admin: Developers will need full control
    Notes: Costs will be isolated
    Dept: Research
    Owner: Brad Cocco

#>

az group create --name 'plaz-dev-rg' --location 'East US'

<#

    Resource Group

    Name: plaz-app1-rg
    Purpose: Consolidate the resources needed for an application
    Need: Isolated from other resources
    Admin: Developers will need to update the application periodically
    Notes: No additional resources should be added after application deployment
    Dept: IT
    Owner: Brad Thomas

#>

# show this information
az group show --name 'plaz-dev-rg'
<#

    {
        "id": "/subscriptions/37737d39-ce91-40f4-9612-6c114c35324d/resourceGroups/plaz-dev-rg",
        "location": "eastus",
        "managedBy": null,
        "name": "plaz-dev-rg",
        "properties": {
            "provisioningState": "Succeeded"
        },
        "tags": null
    }

#>

<#

    Resource Group

    Name: plaz-app1-rg
    Purpose: Consolidate the resources needed for an application
    Need: Isolated from other resources
    Admin: Developers will need to update the application periodically
    Notes: No additional resources should be added after application deployment
    Dept: IT
    Owner: Brad Thomas

#>

# Get Resource Group Tags
(Get-AzureRmResourceGroup -Name 'plaz-net-rg').Tags
<#

    Name                           Value
    ----                           -----
    Owner                          InhoffBehili
    Dept                           IT

#>

Set-AzureRmResourceGroup -Name 'plaz-prod1-rg' -Tag @{ Dept='IT'; Owner='SusanBerlin'}
<#

    ResourceGroupName : plaz-prod1-rg
    Location          : westus
    ProvisioningState : Succeeded
    Tags              :
                        Name   Value
                        =====  ===========
                        Owner  SusanBerlin
                        Dept   IT

    ResourceId        : /subscriptions/37737d39-ce91-40f4-9612-6c114c35324d/resourceGroups/plaz-prod1-rg

#>

Set-AzureRmResourceGroup -Name plaz-dev-rg -Tag @{ Dept='Research'; Owner='BradThomas' }
<#

    ResourceGroupName : plaz-dev-rg
    Location          : eastus
    ProvisioningState : Succeeded
    Tags              :
                        Name   Value
                        Owner  BradThomas
                        Dept   Research

    ResourceId        : /subscriptions/37737d39-ce91-40f4-9612-6c114c35324d/resourceGroups/plaz-dev-rg

#>

# Setting another tag in same RG blats the existing tags
Set-AzureRmResourceGroup -Name plaz-dev-rg -Tag @{ CostCenter='Research' }
<#

    ResourceGroupName : plaz-dev-rg
    Location          : eastus
    ProvisioningState : Succeeded
    Tags              :
                        Name        Value
                        ==========  ========
                        CostCenter  Research

    ResourceId        : /subscriptions/37737d39-ce91-40f4-9612-6c114c35324d/resourceGroups/plaz-dev-rg

#>

# Proper way to add tags
Set-AzureRmResourceGroup -Name plaz-dev-rg -Tag @{ Dept='Research'; Owner='BradThomas' }
$tags = (Get-AzureRmResourceGroup -Name plaz-dev-rg).Tags
$tags.Add('CostCenter', 'Research')
Set-AzureRmResourceGroup -Name plaz-dev-rg -Tag $tags

# Test again
(Get-AzureRmResourceGroup -Name plaz-dev-rg).Tags
<#

    Name                           Value
    ----                           -----
    CostCenter                     Research
    Dept                           Research
    Owner                          BradThomas

#>

# CLI: get tags
az group show --resource-group plaz-dev-rg --query tags
<#

    {
    "CostCenter": "Research",
    "Dept": "Research",
    "Owner": "BradThomas"
    }

#>

# CLI: set tags
az group update --resource-group plaz-app1-rg --set tags.Owner=BradCocco tags.Dept=IT
<#

    {
    "id": "/subscriptions/37737d39-ce91-40f4-9612-6c114c35324d/resourceGroups/plaz-app1-rg",
    "location": "centralus",
    "managedBy": null,
    "name": "plaz-app1-rg",
    "properties": {
        "provisioningState": "Succeeded"
    },
    "tags": {
        "Dept": "IT",
        "Owner": "BradCocco"
    },
    "type": null
    }

#>

# Erase tags
Set-AzureRmResourceGroup -Name plaz-prod1-rg -Tag @{}

<#

    Resource Group Locks
    ====================

    Prevent accidental deletion or changes to resources in resource groups.
    Consist of two locks: -

    1. CanNotDelete
    2. ReadOnly

#>

# Create a lock on the Resource Group
New-AzureRmResourceLock -LockName 'prod1NoDelete' -LockLevel CanNotDelete -ResourceGroupName 'plaz-prod1-rg'
<#

    Confirm
    Are you sure you want to create the following lock:
    /subscriptions/37737d39-ce91-40f4-9612-6c114c35324d/resourceGroups/plaz-prod1-rg/providers/Microsoft.Authorization/locks/prod1NoDelete
    [Y] Yes  [N] No  [S] Suspend  [?] Help (default is "Y"): y


    Name              : prod1NoDelete
    ResourceId        : /subscriptions/37737d39-ce91-40f4-9612-6c114c35324d/resourceGroups/plaz-prod1-rg/providers/Microsoft.Authorization/locks/prod1NoDelete
    ResourceName      : prod1NoDelete
    ResourceType      : Microsoft.Authorization/locks
    ResourceGroupName : plaz-prod1-rg
    SubscriptionId    : 37737d39-ce91-40f4-9612-6c114c35324d
    Properties        : @{level=CanNotDelete}
    LockId            : /subscriptions/37737d39-ce91-40f4-9612-6c114c35324d/resourceGroups/plaz-prod1-rg/providers/Microsoft.Authorization/locks/prod1NoDelete

#>

# Get locks for a given resource group
Get-AzureRmResourceLock -ResourceGroupName 'plaz-prod1-rg'
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

# Create resource group lock using Azure CLI
az lock create --name 'Lockapp1' --lock-type 'ReadOnly' --resource-group 'plaz-app1-rg'
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

# Get lock ID
$lockId = (Get-AzureRmResourceLock -ResourceGroupName 'plaz-prod1-rg').LockId

# Remove lock
Remove-AzureRmResourceLock -LockId $lockId
<#

    Confirm
    Are you sure you want to delete the following lock:
    /subscriptions/37737d39-ce91-40f4-9612-6c114c35324d/resourceGroups/plaz-prod1-rg/providers/Microsoft.Authorization/locks/prod1NoDelete
    [Y] Yes  [N] No  [S] Suspend  [?] Help (default is "Y"): y
    True

#>

# Confirm deletion
Get-AzureRmResourceLock -ResourceGroupName 'plaz-prod1-rg'
<#

    Azure:/
    PS Azure:\>

#>

<#

    Access Control (IAM)
    ====================

    A system that provides fine-grained access management of resources in Azure.
    Grant only the amount of access to users needed to perform their jobs.

    Spec
    ====

    plaz-net-rg
    -----------

    Inhoff = Owner
    IT Group = Contributor

    plaz-prod1-rg
    -------------

    Susan = Owner
    IT Group = Contributor

#>

