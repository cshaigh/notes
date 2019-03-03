<#

    Securing & Controlling Resource Groups
    ======================================

    4 mechanisms

    1. Azure Resource Tags - organise resource groups
    2. Resource Locks - save resources from accidental deletion and changes
    3. Access Control (IAM) - grant access to resources
    4. Azure Policy - enforce rules on resources

#>

<#

    1. Azure Resource Tags
    ======================

    * Logically organise resources
    * Each tag has a name and a value
    * Allows related resources from different resource groups to be identified
    * Organise by billing, management, whatever

    Tag Rules
    ---------

    * Tags are NOT inherited
    * 15 tag name/value pairs
    * Names can't contain these characters: < > % & \ ? /
    * Tags can't be applied to classic resources
    * Tag name is limited to 512 characters
    * Tag value is limited to 256 characters

<#

    Tag Plan
    --------

    plaz-net-rg
    - Dept: IT
    - Owner: InhoffBehili

    plaz-prod1-rg
    - Dept: IT
    - Owner: SusanBerlin

    plaz-dev-rg
    - Dept: Research
    - Owner: BradCocco
    - CostCentre: Research

    plaz-app1-rg
    - Dept: IT
    - Owner: BradThomas

#>

# Get a resource group's tags
(Get-AzureRmResourceGroup -Name plaz-net-rg).Tags
<#

    Name                           Value
    ----                           -----
    Owner                          InhoffBehili
    Dept                           IT

#>

# Set tags for plaz-prod1-rg
Set-AzureRmResourceGroup -Name plaz-prod1-rg -Tag @{ Dept="IT"; Owner="SusanBerlin" }
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

# Set tags for plaz-dev-rg
Set-AzureRmResourceGroup -Name plaz-dev-rg -Tag @{ Dept="Research"; Owner="BradThomas" }
<#

    ResourceGroupName : plaz-dev-rg
    Location          : eastus
    ProvisioningState : Succeeded
    Tags              :
                        Name   Value
                        =====  ==========
                        Owner  BradThomas
                        Dept   Research

    ResourceId        : /subscriptions/37737d39-ce91-40f4-9612-6c114c35324d/resourceGroups/plaz-dev-rg

#>

# Add CostCentre tag to plaz-dev-rg...
Set-AzureRmResourceGroup -Name plaz-dev-rg -Tag @{ CostCentre="Research" }
<#

    ResourceGroupName : plaz-dev-rg
    Location          : eastus
    ProvisioningState : Succeeded
    Tags              :
                        Name        Value
                        ==========  ========
                        CostCentre  Research

    ResourceId        : /subscriptions/37737d39-ce91-40f4-9612-6c114c35324d/resourceGroups/plaz-dev-rg

#>

# Oops!  Other tags were erased!

# Fix and add using array commands...
Set-AzureRmResourceGroup -Name plaz-dev-rg -Tag @{ Dept="Research"; Owner="BradThomas" }
<#

    ResourceGroupName : plaz-dev-rg
    Location          : eastus
    ProvisioningState : Succeeded
    Tags              :
                        Name   Value
                        =====  ==========
                        Owner  BradThomas
                        Dept   Research

    ResourceId        : /subscriptions/37737d39-ce91-40f4-9612-6c114c35324d/resourceGroups/plaz-dev-rg

#>

# Assign current tags to a variable and evaluate this
$tags = (Get-AzureRmResourceGroup -Name plaz-dev-rg).Tags
$tags
<#

    Name                           Value
    ----                           -----
    Owner                          BradThomas
    Dept                           Research

#>

# Add CostCentre tag to tags variable and re-evaluate
$tags.Add("CostCentre", "Research")
$tags
<#

    Name                           Value
    ----                           -----
    Owner                          BradThomas
    CostCentre                     Research
    Dept                           Research

#>

# Now, assign tags variable to resource group
Set-AzureRmResourceGroup -Name plaz-dev-rg -Tag $tags
<#

    ResourceGroupName : plaz-dev-rg
    Location          : eastus
    ProvisioningState : Succeeded
    Tags              :
                        Name        Value
                        ==========  ==========
                        Owner       BradThomas
                        CostCentre  Research
                        Dept        Research

    ResourceId        : /subscriptions/37737d39-ce91-40f4-9612-6c114c35324d/resourceGroups/plaz-dev-rg

#>

# Show tags using Azure CLI
az group show --name plaz-dev-rg --query tags
<#

    {
    "CostCentre": "Research",
    "Dept": "Research",
    "Owner": "BradThomas"
    }

#>

# Find the owner
az group show --name plaz-dev-rg --query tags.Owner
<#

    "BradThomas"

#>

# Update resource group tags with a single command
az group update --name plaz-app1-rg --set tags.Owner=BradCocco tags.Dept=IT
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

# Erase all tags in a group
Set-AzureRmResourceGroup -Name plaz-prod1-rg -Tag @{}
<#

    ResourceGroupName : plaz-prod1-rg
    Location          : westus
    ProvisioningState : Succeeded
    Tags              :
    ResourceId        : /subscriptions/37737d39-ce91-40f4-9612-6c114c35324d/resourceGroups/plaz-prod1-rg

#>

# Re-instate tags
Set-AzureRmResourceGroup -Name plaz-prod1-rg -Tag @{ Dept="IT"; Owner="SusanBerlin" }

# In the Azure Portal, can browse the Tags section to find matching resources to specific tag values