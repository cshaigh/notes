<#

    Role Based Access Control (RBAC)
    ================================
    
    * facilitates Microsoft Azure delegated resource administration
    * roles organise related resource permissions together
    * >60 built-in roles
    * roles vary depending on specific resource, e.g. storage accounts have different roles to VM instances
    * custom roles can also be created

    * roles are applied to a scope
        - management groups
        - subscriptions
        - resource groups
        - individual resources

    * roles are assigned to
        - users
        - groups
        - service principals

    Role Inheritance
    ----------------

    A user is assigned the Virtual Machine Contributor role at the subscription
    * user inherits the role for all resource groups within this subscription

    Microsoft Azure Built-in and Custom Roles
    =========================================

    Built-in roles
    --------------

    Owner                           manage resources AND resource access
    Contributor                     manage resources but NOT resource access
    Reader                          read-only access
    Storage Blob Data Reader        specific to storage accounts
    SQL DB Contributor              manage, but NOT access, SQL databases
    Virtual Machine Contributor     manage, but NOT access, VMs

    Custom roles
    ------------

    * use when built-in roles don't satisfy management delegation requirements
    * built using PowerShell, Azure CLI or the REST API
    * after creation, share same dropdown lists with built-in roles in portal

#>

# Define a custom role in PowerShell

# get current subscription
$subscription = Get-AzureRmSubscription

# get built-in role as a template
$customRole = Get-AzureRmRoleDefinition -Name "Virtual Machine Contributor"

# Override customRole properties
$customRole.Id = $null
$customRole.Name = "Virtual Machine Starter"
$customRole.Description = "Provides the ability to start a virtual machine."

$customRole.Actions = @(
    "Microsoft.Storage/*/read",
    "Microsoft.Network/*/read",
    "Microsoft.Compute/*/read",
    "Microsoft.Compute/virtualMachines/start/action",
    "Microsoft.Authorization/*/read",
    "Microsoft.Resources/subscriptions/resourceGroups/read",
    "Microsoft.Insights/alertrules/*"
)

$customRole.AssignableScopes = "/subscriptions/$($subscription.Id)"

# see completed new customRole
$customRole
<#

    Name             : Virtual Machine Starter
    Id               :
    IsCustom         : False
    Description      : Provides the ability to start a virtual machine.
    Actions          : {Microsoft.Storage/*/read, Microsoft.Network/*/read, Microsoft.Compute/*/read, Microsoft.Compute/virtualMachines/start/action...}
    NotActions       : {}
    DataActions      : {}
    NotDataActions   : {}
    AssignableScopes : {/subscriptions/37737d39-ce91-40f4-9612-6c114c35324d}

#>

# Create new role definition
New-AzureRmRoleDefinition -Role $customRole
<#

    ame             : Virtual Machine Starter
    Id               : e9e25ee2-35b7-4056-a7d5-9645c6160dc0
    IsCustom         : True
    Description      : Provides the ability to start a virtual machine.
    Actions          : {Microsoft.Storage/*/read, Microsoft.Network/*/read, Microsoft.Compute/*/read, Microsoft.Compute/virtualMachines/start/action...}
    NotActions       : {}
    DataActions      : {}
    NotDataActions   : {}
    AssignableScopes : {/subscriptions/37737d39-ce91-40f4-9612-6c114c35324d}

#>

# Create custom role using Azure CLI

# create custom role JSON
$customRoleJson = @"
{
    "Name": "Network Resource Viewer",
    "IsCustom": true,
    "Description": "Allows reading Azure network resources.",
    "Actions": [
        "Microsoft.Network/*/read"
    ],
    "NotActions": [

    ],
    "AssignableScopes": [
        "/subscriptions/$($subscription.Id)"
    ]
}
"@

# test
$customRoleJson
<#

{
    "Name": "Network Resource Viewer",
    "IsCustom": true,
    "Description": "Allows reading Azure network resources.",
    "Actions": [
        "Microsoft.Network/*/read"
    ],
    "NotActions": [

    ],
    "AssignableScopes": [
        "/subscriptions/37737d39-ce91-40f4-9612-6c114c35324d"
    ]
}

#>

# stash this in customRole.json, then...
az role definition create --role-definition customRole.json
<#

    {
    "assignableScopes": [
        "/subscriptions/37737d39-ce91-40f4-9612-6c114c35324d"
    ],
    "description": "Allows reading Azure network resources.",
    "id": "/subscriptions/37737d39-ce91-40f4-9612-6c114c35324d/providers/Microsoft.Authorization/roleDefinitions/52451b75-3067-4ad2-b17d-e7f98eccdd49",
    "name": "52451b75-3067-4ad2-b17d-e7f98eccdd49",
    "permissions": [
        {
        "actions": [
            "Microsoft.Network/*/read"
        ],
        "dataActions": [],
        "notActions": [],
        "notDataActions": []
        }
    ],
    "roleName": "Network Resource Viewer",
    "roleType": "CustomRole",
    "type": "Microsoft.Authorization/roleDefinitions"
    }

#>

# verify
az role definition list --custom-role-only | grep "roleName"
<#

    "roleName": "Network Resource Viewer",
    "roleName": "Virtual Machine Starter",

#>