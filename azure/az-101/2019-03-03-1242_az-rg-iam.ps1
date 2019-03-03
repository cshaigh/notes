<#

    Access Control (IAM)
    ====================

    * A system that provides fine-grained access management of resources in Azure
    * Grant only the amount of access to users needed to perform their jobs

#>

<#

    IAM plan
    --------

    plaz-net-rg
    - Inhoff = Owner
    - IT Group = Contributor

    plaz-prod1-rg
    - Susan = Owner
    - IT Group = Contributor

    plaz-dev-rg
    - Jenn = Reader
    - Research Group = Owner

    plaz-app1-rg
    - BradT = Owner
    - IT Group = Virtual Machine Contributor

#>

# Get role assignments for resource group
Get-AzureRmRoleAssignment -ResourceGroupName plaz-prod1-rg
<#

    RoleAssignmentId   : /subscriptions/37737d39-ce91-40f4-9612-6c114c35324d/resourceGroups/plaz-prod1-rg/providers/Microsoft.Authorization/roleAssignments/8d2db4e6-e3a9-4843-9055-84fa4c13a571
    Scope              : /subscriptions/37737d39-ce91-40f4-9612-6c114c35324d/resourceGroups/plaz-prod1-rg
    DisplayName        : cs.haigh
    SignInName         : cs.haigh_yahoo.co.uk#EXT#@cshaigh1981gmail.onmicrosoft.com
    RoleDefinitionName : Owner
    RoleDefinitionId   : 8e3af657-a8ff-443c-a75c-2fe8c4bcb635
    ObjectId           : f8d42361-cd05-4dfb-9610-cbbb72b8234b
    ObjectType         : User
    CanDelegate        : False

    RoleAssignmentId   : /subscriptions/37737d39-ce91-40f4-9612-6c114c35324d/resourceGroups/plaz-prod1-rg/providers/Microsoft.Authorization/roleAssignments/35fa3fa0-f09b-41cd-9caf-349127a2e00a
    Scope              : /subscriptions/37737d39-ce91-40f4-9612-6c114c35324d/resourceGroups/plaz-prod1-rg
    DisplayName        : IT
    SignInName         :
    RoleDefinitionName : Contributor
    RoleDefinitionId   : b24988ac-6180-42a0-ab88-20f7382dd24c
    ObjectId           : 7fb8295f-2695-41ce-a5b8-695b07ab8e06
    ObjectType         : Group
    CanDelegate        : False

#>

# More readable version
Get-AzureRmRoleAssignment -ResourceGroupName plaz-prod1-rg | Select-Object DisplayName, RoleDefinitionName, ObjectType
<#

    DisplayName RoleDefinitionName ObjectType
    ----------- ------------------ ----------
    cs.haigh    Owner              User
    IT          Contributor        Group

#>

# Assign Hannah to plaz-dev-rg
New-AzureRmRoleAssignment `
    -SignInName (Get-AzureRmADUser -DisplayName hleatherday).UserPrincipalName `
    -RoleDefinitionName Reader `
    -ResourceGroupName plaz-dev-rg

<#

    RoleAssignmentId   : /subscriptions/37737d39-ce91-40f4-9612-6c114c35324d/resourceGroups/plaz-dev-rg/providers/Microsoft.Authorization/roleAssignments/6be2920b-56f1-4963-87c5-f6802681b4f6
    Scope              : /subscriptions/37737d39-ce91-40f4-9612-6c114c35324d/resourceGroups/plaz-dev-rg
    DisplayName        : hleatherday
    SignInName         : hleatherday_gmail.com#EXT#@cshaigh1981gmail.onmicrosoft.com
    RoleDefinitionName : Reader
    RoleDefinitionId   : acdd72a7-3385-48ef-bd42-f606fba81ae7
    ObjectId           : d3febc3d-3d45-4023-9970-a31c45cec3d9
    ObjectType         : User
    CanDelegate        : False

#>

# Assign Research group as Owner of plaz-dev-rg group
New-AzureRmRoleAssignment -ObjectId (Get-AzureRmADGroup -SearchString Research).Id -RoleDefinitionName Owner -ResourceGroupName plaz-dev-rg
<#

    RoleAssignmentId   : /subscriptions/37737d39-ce91-40f4-9612-6c114c35324d/resourceGroups/plaz-dev-rg/providers/Microsoft.Authorization/roleAssignments/2e89e8df-8cd8-41bd-924e-345e88f7351d
    Scope              : /subscriptions/37737d39-ce91-40f4-9612-6c114c35324d/resourceGroups/plaz-dev-rg
    DisplayName        : Research
    SignInName         :
    RoleDefinitionName : Owner
    RoleDefinitionId   : 8e3af657-a8ff-443c-a75c-2fe8c4bcb635
    ObjectId           : 115d8b52-5622-4a65-bc18-6cb1ba5d06c5
    ObjectType         : Group
    CanDelegate        : False

#>

# Use Azure CLI to see role assignments for plaz-dev-rg
az role assignment list --resource-group plaz-dev-rg
<#

    [
    {
        "canDelegate": null,
        "id": "/subscriptions/37737d39-ce91-40f4-9612-6c114c35324d/resourceGroups/plaz-dev-rg/providers/Microsoft.Authorization/roleAssignments/2e89e8df-8cd8-41bd-924e-345e88f7351d",
        "name": "2e89e8df-8cd8-41bd-924e-345e88f7351d",
        "principalId": "115d8b52-5622-4a65-bc18-6cb1ba5d06c5",
        "principalName": "Research",
        "resourceGroup": "plaz-dev-rg",
        "roleDefinitionId": "/subscriptions/37737d39-ce91-40f4-9612-6c114c35324d/providers/Microsoft.Authorization/roleDefinitions/8e3af657-a8ff-443c-a75c-2fe8c4bcb635",
        "roleDefinitionName": "Owner",
        "scope": "/subscriptions/37737d39-ce91-40f4-9612-6c114c35324d/resourceGroups/plaz-dev-rg",
        "type": "Microsoft.Authorization/roleAssignments"
    },
    {
        "canDelegate": null,
        "id": "/subscriptions/37737d39-ce91-40f4-9612-6c114c35324d/resourceGroups/plaz-dev-rg/providers/Microsoft.Authorization/roleAssignments/6be2920b-56f1-4963-87c5-f6802681b4f6",
        "name": "6be2920b-56f1-4963-87c5-f6802681b4f6",
        "principalId": "d3febc3d-3d45-4023-9970-a31c45cec3d9",
        "principalName": "hleatherday_gmail.com#EXT#@cshaigh1981gmail.onmicrosoft.com",
        "resourceGroup": "plaz-dev-rg",
        "roleDefinitionId": "/subscriptions/37737d39-ce91-40f4-9612-6c114c35324d/providers/Microsoft.Authorization/roleDefinitions/acdd72a7-3385-48ef-bd42-f606fba81ae7",
        "roleDefinitionName": "Reader",
        "scope": "/subscriptions/37737d39-ce91-40f4-9612-6c114c35324d/resourceGroups/plaz-dev-rg",
        "type": "Microsoft.Authorization/roleAssignments"
    }
    ]

#>

# Reader-friendly query
az role assignment list --resource-group plaz-dev-rg --query "[].[principalName, roleDefinitionName]"
<#

    [
    [
        "Research",
        "Owner"
    ],
    [
        "hleatherday_gmail.com#EXT#@cshaigh1981gmail.onmicrosoft.com",
        "Reader"
    ]
    ]

#>

# Assign cs.haigh@yahoo.co.uk as Owner of plaz-app1-rg...
# First, get list of AD users and filter in a readable way
az ad user list --query "[].[displayName, userPrincipalName]"
<#

    [
    [
        "christopher_haig",
        "christopher_haig_hotmail.com#EXT#@cshaigh1981gmail.onmicrosoft.com"
    ],
    [
        "cs.haigh",
        "cs.haigh_yahoo.co.uk#EXT#@cshaigh1981gmail.onmicrosoft.com"
    ],
    [
        "ef1c1ba7-1bb6-4326-b42d-3286d1134fd6 c46b86c7-7f40-4b6b-a9e1-8f9a9ffc5182",
        "cshaigh1981_gmail.com#EXT#@cshaigh1981gmail.onmicrosoft.com"
    ],
    [
        "hleatherday",
        "hleatherday_gmail.com#EXT#@cshaigh1981gmail.onmicrosoft.com"
    ]
    ]

#>

# Then, get userPrincipalName (UPN) for user cs.haigh, flatten, assign to variable and evaluate

# PowerShell VERSION
$userPrincipalName = (az ad user list --query "[?displayName=='cs.haigh'].userPrincipalName|[0]")
$userPrincipalName

# Assign cs.haigh as Owner of plaz-app1-rg
az role assignment create --role Owner --assignee $userPrincipalName --resource-group plaz-app1-rg
<#

    The scope '/subscriptions/37737d39-ce91-40f4-9612-6c114c35324d/resourceGroups/plaz-app1-rg/providers/Microsoft.Authorization/roleAssignments/e0b7451d-8f41-491b-b248-569b86897aef' cannot perform write operation because following scope(s) are locked: '/subscriptions/37737d39-ce91-40f4-9612-6c114c35324d/resourceGroups/plaz-app1-rg'. Please remove the lock and try again.

#>

# Get locks
az lock list --resource-group plaz-app1-rg --query "[].name|[0]"
<#

    "Lockapp1"

#>

# Change lock type to allow role assignment changes to resource group
az lock update --name Lockapp1 --resource-group plaz-app1-rg --lock-type CanNotDelete
<#

    {
        "id": "/subscriptions/37737d39-ce91-40f4-9612-6c114c35324d/resourceGroups/plaz-app1-rg/providers/Microsoft.Authorization/locks/Lockapp1",
        "level": "CanNotDelete",
        "name": "Lockapp1",
        "notes": null,
        "owners": null,
        "resourceGroup": "plaz-app1-rg",
        "type": "Microsoft.Authorization/locks"
    }

#>

# Assign cs.haigh as Owner of plaz-app1-rg
az role assignment create --role Owner --assignee $userPrincipalName --resource-group plaz-app1-rg
<#

    {
        "canDelegate": null,
        "id": "/subscriptions/37737d39-ce91-40f4-9612-6c114c35324d/resourceGroups/plaz-app1-rg/providers/Microsoft.Authorization/roleAssignments/fa021642-1ca4-4d14-ae2a-da1f7ed72210",
        "name": "fa021642-1ca4-4d14-ae2a-da1f7ed72210",
        "principalId": "f8d42361-cd05-4dfb-9610-cbbb72b8234b",
        "resourceGroup": "plaz-app1-rg",
        "roleDefinitionId": "/subscriptions/37737d39-ce91-40f4-9612-6c114c35324d/providers/Microsoft.Authorization/roleDefinitions/8e3af657-a8ff-443c-a75c-2fe8c4bcb635",
        "scope": "/subscriptions/37737d39-ce91-40f4-9612-6c114c35324d/resourceGroups/plaz-app1-rg",
        "type": "Microsoft.Authorization/roleAssignments"
    }

#>

# Get IT Group's objectId, assign to variable and evaluate
$groupId = (az ad group list --query "[?displayName=='IT'].objectId|[0]")
$groupId
<#

    "7fb8295f-2695-41ce-a5b8-695b07ab8e06"

#>

# Assign IT group to Virtual Machine Contributor role in plaz-app1-rg resource group
az role assignment create --role "Virtual Machine Contributor" --assignee-object-id $groupId --resource-group plaz-app1-rg
<#

    {
        "canDelegate": null,
        "id": "/subscriptions/37737d39-ce91-40f4-9612-6c114c35324d/resourceGroups/plaz-app1-rg/providers/Microsoft.Authorization/roleAssignments/8b47315c-d954-48df-8508-1586ff63305d",
        "name": "8b47315c-d954-48df-8508-1586ff63305d",
        "principalId": "7fb8295f-2695-41ce-a5b8-695b07ab8e06",
        "resourceGroup": "plaz-app1-rg",
        "roleDefinitionId": "/subscriptions/37737d39-ce91-40f4-9612-6c114c35324d/providers/Microsoft.Authorization/roleDefinitions/9980e02c-c2be-4d73-94e8-173b1dc7cf3c",
        "scope": "/subscriptions/37737d39-ce91-40f4-9612-6c114c35324d/resourceGroups/plaz-app1-rg",
        "type": "Microsoft.Authorization/roleAssignments"
    }

#>

# Check role assignment list again
az role assignment list --resource-group plaz-app1-rg --query "[].[principalName, roleDefinitionName]"
<#

    [
        [
            "cs.haigh_yahoo.co.uk#EXT#@cshaigh1981gmail.onmicrosoft.com",
            "Owner"
        ],
        [
            "IT",
            "Virtual Machine Contributor"
        ]
    ]

#>

# Finally, reinstate lock
az lock update --name Lockapp1 --resource-group plaz-app1-rg --lock-type ReadOnly
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