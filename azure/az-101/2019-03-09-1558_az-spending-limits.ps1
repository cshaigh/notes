<#

    Microsoft Azure Spending Limits
    ===============================

    * help prevent the usage of credits belong the credits available

    Spending Limits Applicability
    -----------------------------

    Yes
    - Free Trial
    - MSDN
    - Visual Studio

    No
    - Support Plans
    - Enterprise Dev/test
    - PAYG

    Spending Limit Exceeded
    -----------------------

    * An email message is sent
    * Deployed resources are disabled until the next billing cycle
    * Databases and storage accounts become read-only
    * Exceeded free trials can be upgraded to PAYG
    * Remove spending limits by creating a subscription payment method

    Microsoft Azure ARM Consumption APIs
    ====================================

    * provide a way for both administrators and developers to programmatically access information related to charges in the Azure cloud

    Azure Consumption APIs
    ----------------------

    * Returns resource usage details and cost through REST API calls
    * Supported subscription types: -
        - Enterprise enrollments
        - Web Direct subscriptions

    * Programmatic access
        - Microsoft Azure CLI
        - Python, .NET, Node.js, Ruby, PowerShell


    Enterprise-only APIs
    ~~~~~~~~~~~~~~~~~~~~

    API Name                    Description
    --------                    -----------

    Price Sheet                 Resource usage and pricing expressed using various units of measurement, e.g. hours, GB

    Budgets                     Manage costs and usage budgets and alerts

    Balance                     Current or previous billing summary


    Standard APIs
    ~~~~~~~~~~~~~

    API Name                    Description
    --------                    -----------

    Reservation Summaries       Summary of reserved virtual machine instance reserved consumption vs. actual usage

    Reservation Details         Reserved virtual machine usage

    Reservation Recommendations Suggested reserved virtual machine instance usage and savings

    Marketplace Charges         Marketplace resource usage and fee details

    Usage Details               Resource usage and fee details


    Other Cost and Billing Management Tools
    =======================================

    * Microsoft Azure Pricing Calculator
    * Microsoft Azure Advisor cost recommendations

    Azure Advisor Cost Recommendations
    ==================================

    * Virtual machine shutdown
        - Manual
        - Automatic

    * Virtual machine resizing
        -   Vertical scaling (down)

    * Use virtual machine reserved instances

    * Remove unprovisioned ExpressRoute circuits

#>

# Download Azure Billing Invoice
$invoice = Get-AzureRmBillingInvoice -Latest
Invoke-WebRequest -Uri $invoice.DownloadUrl -OutFile .\$($invoice.Name).pdf

# List billing invoices using Azure CLI
az billing invoice list
<#

    [
        {
            "billingPeriodIds": [
                "/subscriptions/37737d39-ce91-40f4-9612-6c114c35324d/providers/Microsoft.Billing/billingPeriods/201904-1"
            ],
            "downloadUrl": null,
            "id": "/subscriptions/37737d39-ce91-40f4-9612-6c114c35324d/providers/Microsoft.Billing/invoices/201904-119223190701201",
            "invoicePeriodEndDate": "2019-03-02",
            "invoicePeriodStartDate": "2019-02-03",
            "name": "201904-119223190701201",
            "type": "Microsoft.Billing/invoices"
        }
    ]

#>

# Get first invoice's name
invoiceName=$(az billing invoice list --query "[0].[name]" --output tsv)

# Show this billing invoice
az billing invoice show --name $invoiceName
<#

    {
        "billingPeriodIds": [
            "/subscriptions/37737d39-ce91-40f4-9612-6c114c35324d/providers/Microsoft.Billing/billingPeriods/201904-1"
        ],
        "downloadUrl": {
            "expiryTime": "2019-03-09T18:40:18+00:00",
            "url": "https://billinginsightsstore05.blob.core.windows.net/invoices/37737d39-ce91-40f4-9612-6c114c35324d-201904-119223190701201.pdf?sv=2014-02-14&sr=b&sig=BfXu11Q1faRvDHBvLD5h06Uz8xAsJECaozkCEojklhA%3D&se=2019-03-09T18%3A40%3A18Z&sp=r"
        },
        "id": "/subscriptions/37737d39-ce91-40f4-9612-6c114c35324d/providers/Microsoft.Billing/invoices/201904-119223190701201",
        "invoicePeriodEndDate": "2019-03-02",
        "invoicePeriodStartDate": "2019-02-03",
        "name": "201904-119223190701201",
        "type": "Microsoft.Billing/invoices"
    }

#>

# Get billing invoice URL
az billing invoice show --name $invoiceName --query "downloadUrl.url"
<#

    "https://billinginsightsstore05.blob.core.windows.net/invoices/37737d39-ce91-40f4-9612-6c114c35324d-201904-119223190701201.pdf?sv=2014-02-14&sr=b&sig=Nv2Ab0z622XGuPfu3L%2FE%2FCHMZGawMtu%2FwDXmozAgfwA%3D&se=2019-03-09T18%3A42%3A24Z&sp=r"

#>