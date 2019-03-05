<#

    Microsoft Azure Policies ensure proper cloud governance by controlling resource deployment and usage

    Microsoft Azure Built-in Policies
    =================================

    Policy Name                         Description
    -----------                         -----------

    Require SQL Server 12.0             Ensures SQL servers are version 12.0
    Allow Storage Account SKUs          Controls Storage Account SKU sizes
    Allowed Resource Type               Controls which types of resources can be deployed
    Allowed Locations                   Controls which locations that resources can be deployed into
    Allowed Virtual Machine SKUs        Limits virtual machine SKUs that can be deployed
    Apply tag and its default value     If the specified tag is not provided by the user, apply a default value
    Enforce tag and its value           Resource deployment succeeds only if a specific tag and value are supplied
    Not allowed resource types          Lists resources that cannot be deployed

    Custom Policies
    ===============

    * JSON format
    * Used for granular resource control
        - e.g. limit load balancer creation to IT admins

    * Custom policies can be created
        - manually
        - copy existing policy and tweak
        - GitHub

    Policy Parameters
    =================

    * Variable values are passed to the policy
    * Enables policy reuse
        - Fewer policies are required

    * String or array data type

    Policy Assignment
    =================

    * Built-in and custom policies can be assigned
        - Azure portal
        - PowerShell
        - CLI

    * Assignment permission requirement
        - Microsoft.Authorization/policyassignments/write

    Policy Effects
    ==============

    Effect              Description
    ------              -----------

    Append              Resource property additions, including tags
    Audit               Logging only; generates a warning
    AuditIfNotExists    Auditing is enabled if resource doesn't exist
    Deny                Existing non-compliant resources are marked as non-compliant, but not deleted
    DeployIfNotExists   If the resource does not already exist, deploy it

    Policy Assignment - Management Groups
    =====================================

    * Used to organise Azure subscriptions
    * Up to 6 heirarchical levels can be created
    * Subscriptions inherit settings
    * Facilitates role-based access control (RBAC)
    * Subscriptions can be moved to other parts of the heirarchy

    Policy Assignment
    =================

    * Subscription
        - Exclusions can apply to child items such as resource groups

    * Resource group
        - Exclusions can apply to child items such as virtual machines
    
    Policy Initiative Definitions
    =============================

    * Groups policies into a single unit
    * Used when a single Azure governance goal consists of multiple checks
    * Example: -
        - Initiative Definition: Security Compliance

                    Security Compliance
                    /                  \
        Check for endpoint      Check for VM disk
            protection              encryption

    Microsoft Azure Policy Compliance
    =================================

    * Policies apply to new and existing resources
    * Resources are scanned hourly for compliance with policies
    * Geo-compliance
        - "Allowed Locations" built-in policy
#>

# Assign resource group to variable
$resourceGroup = Get-AzureRmResourceGroup -Name plaz-dev-rg

# Get desired policy definition
$policyDefinition = Get-AzureRmPolicyDefinition | Where-Object { $_.Properties.DisplayName -eq "Audit VMs that do not use managed disks" }

# Assign policy definition to resource group
New-AzureRmPolicyAssignment `
    -Name "Check for Managed Disks"     
    -DisplayName "Check for Managed Disks"  
    -Scope $resourceGroup.ResourceId    
    -PolicyDefinition $policyDefinition

<#

    Name               : Check for Managed Disks
    ResourceId         : /subscriptions/37737d39-ce91-40f4-9612-6c114c35324d/resourceGroups/plaz-dev-rg/providers/Microsoft.Authorization/policyAssignments/Check for Managed Disks
    ResourceName       : Check for Managed Disks
    ResourceType       : Microsoft.Authorization/policyAssignments
    ResourceGroupName  : plaz-dev-rg
    SubscriptionId     : 37737d39-ce91-40f4-9612-6c114c35324d
    Properties         : @{displayName=Check for Managed Disks; policyDefinitionId=/providers/Microsoft.Authorization/policyDefinitions/06a78e20-9358-41c9-923c-fb736d382a4d;
                        scope=/subscriptions/37737d39-ce91-40f4-9612-6c114c35324d/resourceGroups/plaz-dev-rg; metadata=}
    Sku                : @{name=A0; tier=Free}
    PolicyAssignmentId : /subscriptions/37737d39-ce91-40f4-9612-6c114c35324d/resourceGroups/plaz-dev-rg/providers/Microsoft.Authorization/policyAssignments/Check for Managed Disks

#>

# Use CLI to find out commands to manage resource policies.
az policy --help
<#

    Group
        az policy : Manage resource policies.

    Subgroups:
        assignment     : Manage resource policy assignments.
        definition     : Manage resource policy definitions.
        event          : Manage policy events.
        remediation    : Manage resource policy remediations.
        set-definition : Manage resource policy set definitions.
        state          : Manage policy compliance states.

#>

# Use CLI to find out commands to manage resource policy assignments
az policy assignment --help
<#

    Group
        az policy assignment : Manage resource policy assignments.

    Subgroups:
        identity : Manage a policy assignment's managed identity.

    Commands:
        create   : Create a resource policy assignment.
        delete   : Delete a resource policy assignment.
        list     : List resource policy assignments.
        show     : Show a resource policy assignment.

#>

# Show all policy definitions
az policy definition list

# Show accounts in tabular format
az account list --output table
<#

    Name         CloudName    SubscriptionId                        State    IsDefault
    -----------  -----------  ------------------------------------  -------  -----------
    tandem-payg  AzureCloud   37737d39-ce91-40f4-9612-6c114c35324d  Enabled  True

#>

# See policies assigned to a specific subscription
az policy assignment list --subscription 37737d39-ce91-40f4-9612-6c114c35324d