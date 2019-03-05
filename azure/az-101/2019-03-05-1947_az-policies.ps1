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

