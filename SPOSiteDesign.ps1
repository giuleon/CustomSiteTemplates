$TenantName = "giuleon"
Connect-SPOService -Url https://$TenantName-admin.sharepoint.com

Get-SPOSiteDesign c765f79a-2bcf-4eec-923d-0b874ec57453
Set-SPOSiteDesign -Identity c765f79a-2bcf-4eec-923d-0b874ec57453 -ThumbnailUrl "" -PreviewImageUrl ""


#$script = Get-Clipboard -Raw
$script = @"
{
  "$schema": "schema.json",
  "actions": [
      {
          "verb": "triggerFlow",
          "url": "https://prod-36.westeurope.logic.azure.com:443/workflows/fa1f03d9ffde402f935266d5eb97e8ac/triggers/manual/paths/invoke?api-version=2016-06-01&sp=%2Ftriggers%2Fmanual%2Frun&sv=1.0&sig=CGI3N0qbxwRulEXAYoFLooCgMmJDafmzi2Eg8o547SI",
          "name": "Record site creation event",
          "parameters": {
              "event": "site creation",
              "product": "SharePoint Online"
          }
      },
      {
          "verb": "applyTheme",
          "themeName": "Blue Yonder"
      },
      {
          "verb": "createSPList",
          "listName": "Customer Tracking",
          "templateType": 100,
          "subactions": [
              {
                  "verb": "setDescription",
                  "description": "List of Customers and Orders"
              },
              {
                  "verb": "addSPField",
                  "fieldType": "Text",
                  "displayName": "Customer Name",
                  "isRequired": false,
                  "addToDefaultView": true
              },
              {
                  "verb": "addSPField",
                  "fieldType": "Number",
                  "displayName": "Requisition Total",
                  "addToDefaultView": true,
                  "isRequired": true
              },
              {
                  "verb": "addSPField",
                  "fieldType": "User",
                  "displayName": "Contact",
                  "addToDefaultView": true,
                  "isRequired": true
              },
              {
                  "verb": "addSPField",
                  "fieldType": "Note",
                  "displayName": "Meeting Notes",
                  "isRequired": false
              }
          ]
      },
      {
          "verb": "addNavLink",
          "url": "Lists/Customer Tracking/AllItems.aspx",
          "displayName": "Customer Tracking",
          "isWebRelative": true
      },
      {
          "verb": "addNavLink",
          "url": "SitePages/Our-Mission.aspx",
          "displayName": "Our Mission",
          "isWebRelative": true
      },
      {
          "verb": "addNavLink",
          "url": "SitePages/About-Us.aspx",
          "displayName": "About Us",
          "isWebRelative": true
      }
  ]
}
"@

#Creating a new Site Script
Add-SPOSiteScript -Title "Site Script to provision Site Template Contoso" -Content $script

#Updating an existing one
Get-SPOSiteScript 9823d5c9-e8d5-49e1-aa23-6bebea62b82c
Set-SPOSiteScript -Identity 9823d5c9-e8d5-49e1-aa23-6bebea62b82c -Content $script

Add-SPOSiteDesign `
  -Title "Record site creation" `
  -Description "The creation of this site will be recorded in the site directory list" `
  -SiteScripts 9832d5c9-e8d5-49e1-aa23-6bebea62b82c `
  -WebTemplate "68"

