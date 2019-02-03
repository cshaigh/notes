<#

    Resource Group

    Name: plaz-prod1-rg
    Purpose: Contain the company's VM and their associated dependent resources
    Need: Prevent the accidental deletion of any service or VM
    Admin: IT group will deploy and maintain VMs for the company
    Notes: Resources only in East US location
    Dept: IT
    Owner: Chris Haigh

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
