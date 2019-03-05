# List Azure tags
az tag list
<#
    [
        {
            "count": {
            "type": "Total",
            "value": 1
            },
            "id": "/subscriptions/37737d39-ce91-40f4-9612-6c114c35324d/tagNames/ms-resource-usage",
            "tagName": "ms-resource-usage",
            "values": [
            {
                "count": {
                "type": "Total",
                "value": 1
                },
                "id": "/subscriptions/37737d39-ce91-40f4-9612-6c114c35324d/tagNames/ms-resource-usage/tagValues/azure-cloud-shell",
                "tagValue": "azure-cloud-shell"
            }
            ]
        },
        {
            "count": {
            "type": "Total",
            "value": 2
            },
            "id": "/subscriptions/37737d39-ce91-40f4-9612-6c114c35324d/tagNames/Project",
            "tagName": "Project",
            "values": [
            {
                "count": {
                "type": "Total",
                "value": 2
                },
                "id": "/subscriptions/37737d39-ce91-40f4-9612-6c114c35324d/tagNames/Project/tagValues/ABC",
                "tagValue": "ABC"
            }
            ]
        },
        {
            "count": {
            "type": "Total",
            "value": 3
            },
            "id": "/subscriptions/37737d39-ce91-40f4-9612-6c114c35324d/tagNames/Owner",
            "tagName": "Owner",
            "values": [
            {
                "count": {
                "type": "Total",
                "value": 1
                },
                "id": "/subscriptions/37737d39-ce91-40f4-9612-6c114c35324d/tagNames/Owner/tagValues/BradThomas",
                "tagValue": "BradThomas"
            },
            {
                "count": {
                "type": "Total",
                "value": 1
                },
                "id": "/subscriptions/37737d39-ce91-40f4-9612-6c114c35324d/tagNames/Owner/tagValues/InhoffBehili",
                "tagValue": "InhoffBehili"
            },
            {
                "count": {
                "type": "Total",
                "value": 1
                },
                "id": "/subscriptions/37737d39-ce91-40f4-9612-6c114c35324d/tagNames/Owner/tagValues/SusanBerlin",
                "tagValue": "SusanBerlin"
            }
            ]
        },
        {
            "count": {
            "type": "Total",
            "value": 1
            },
            "id": "/subscriptions/37737d39-ce91-40f4-9612-6c114c35324d/tagNames/CostCentre",
            "tagName": "CostCentre",
            "values": [
            {
                "count": {
                "type": "Total",
                "value": 1
                },
                "id": "/subscriptions/37737d39-ce91-40f4-9612-6c114c35324d/tagNames/CostCentre/tagValues/Research",
                "tagValue": "Research"
            }
            ]
        },
        {
            "count": {
            "type": "Total",
            "value": 3
            },
            "id": "/subscriptions/37737d39-ce91-40f4-9612-6c114c35324d/tagNames/Dept",
            "tagName": "Dept",
            "values": [
            {
                "count": {
                "type": "Total",
                "value": 1
                },
                "id": "/subscriptions/37737d39-ce91-40f4-9612-6c114c35324d/tagNames/Dept/tagValues/Research",
                "tagValue": "Research"
            },
            {
                "count": {
                "type": "Total",
                "value": 2
                },
                "id": "/subscriptions/37737d39-ce91-40f4-9612-6c114c35324d/tagNames/Dept/tagValues/IT",
                "tagValue": "IT"
            }
            ]
        }
    ]
#>

# Show a resource group's tags
az group show --resource-group plaz-dev-rg --query tags
<#

    {
        "CostCentre": "Research",
        "Dept": "Research",
        "Owner": "BradThomas"
    }

#>

# Add tag to resource group
az resource tag --resource-group plaz-app2-rg --resource-type 'Microsoft.Web/sites' --name cshaigh-plazapp2 --tags LifeCycle=Dev Region=Central
<#
    {
        ...

    "tags": {
        "LifeCycle": "Dev",
        "Region": "Central"
    },
    "type": "Microsoft.Web/sites"
    }
#>

