<#

    Removing Resource Groups
    ========================

    * Deleting a resource group deletes all of the resources inside of it
    * This is why locks can be helpful

    Portal Process
    --------------

    1. Select resource group
    2. Settings -> Locks and review/remove existing locks
    3. Overview
    4. Delete resource group
    5. Type in resource group name
    6. Delete

#>

# Delete plaz-vm01-rg in PowerShell (without confirming)
Remove-AzureRmResourceGroup -Name plaz-vm01-rg -Force
<#

    True

#>

# Delete plaz-net2-rg in Azure CLI (without confirming)
az group delete --resource-group plaz-net2-rg --yes