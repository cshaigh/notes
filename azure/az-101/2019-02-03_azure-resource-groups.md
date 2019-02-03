# Azure Resource Groups

## Definition

* container that holds related resources for an Azure solution
* can include all resources for the solution 
* or only those resources that you want to manage as a group

## Rules

Resources: -
* should share the same lifecycle
* can only exist in one resource group
* can be added or removed to a resource group at any time
* can be moved from one RG to another
* RGs can contain resources that reside in different regions
* can interact with resources in other groups

## Convention

* *owner*-*purpose*-rg
* e.g. **chris-website-rg**
* e.g. **microsoft-contoso-payroll-rg**

## Control

4 key controllers: -

1. **tags** - categorisation
2. **locks** - prevent accidental deletion
3. **access control (IAM)** - give users abilities to do things within an RG
4. **policies** - control behaviour

## Super-awesome Resource

https://azure.microsoft.com/en-us/resources/templates/

