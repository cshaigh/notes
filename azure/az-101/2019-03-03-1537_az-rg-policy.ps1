<#

    Azure Policy
    ============

    * Allows you to manage and prevent IT issues with policy definitions that enforce rules and effects for your resources
    * Policies allow you to keep compliant with corporate standards and SLAs.

#>

<#

    Policy Plan
    -----------

    plaz-net-rg
    - Only network resources

    plaz-prod1-rg
    - Only East US location

    plaz-dev-rg
    - None

    plaz-app1-rg
    - No additional resources can be added

#>

# TODO restrict plaz-prod1-rg resources to a specific location
# See here for policy: https://github.com/Azure/azure-policy/tree/master/samples/built-in-policy/allowed-locations

# Create the Policy Definition (Subscription scope)
$definition = New-AzureRmPolicyDefinition `
    -Name "allowed-locations" `
    -DisplayName "Allowed locations" `
    -description "This policy enables you to restrict the locations your organization can specify when deploying resources. Use to enforce your geo-compliance requirements. Excludes resource groups, Microsoft.AzureActiveDirectory/b2cDirectories, and resources that use the 'global' region." `
    -Policy 'https://raw.githubusercontent.com/Azure/azure-policy/master/samples/built-in-policy/allowed-locations/azurepolicy.rules.json' `
    -Parameter 'https://raw.githubusercontent.com/Azure/azure-policy/master/samples/built-in-policy/allowed-locations/azurepolicy.parameters.json' `
    -Mode All

# Set the scope to a resource group; may also be a subscription or management group
$scope = Get-AzureRmResourceGroup -Name plaz-prod1-rg

# Create the Policy Assignment
$assignment = New-AzureRmPolicyAssignment `
    -Name "only East US" `
    -Scope $scope.ResourceId `
    -PolicyDefinition $definition `
    -listOfAllowedLocations "East US"

# See policy assignment
$assignment
<#

    Name               : only East US
    ResourceId         : /subscriptions/37737d39-ce91-40f4-9612-6c114c35324d/resourceGroups/plaz-prod1-rg/providers/Microsoft.Authorization/policyAssignments/only East US
    ResourceName       : only East US
    ResourceType       : Microsoft.Authorization/policyAssignments
    ResourceGroupName  : plaz-prod1-rg
    SubscriptionId     : 37737d39-ce91-40f4-9612-6c114c35324d
    Properties         : @{policyDefinitionId=/subscriptions/37737d39-ce91-40f4-9612-6c114c35324d/providers/Microsoft.Authorization/policyDefinitions/allowed-locations;
                        scope=/subscriptions/37737d39-ce91-40f4-9612-6c114c35324d/resourceGroups/plaz-prod1-rg; parameters=; metadata=}
    Sku                : @{name=A0; tier=Free}
    PolicyAssignmentId : /subscriptions/37737d39-ce91-40f4-9612-6c114c35324d/resourceGroups/plaz-prod1-rg/providers/Microsoft.Authorization/policyAssignments/only East US

#>

