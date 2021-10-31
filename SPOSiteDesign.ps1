$Title = "Site Template Contoso"
$Description = "Site Design & Site Script to provision a custom site template named Contoso"
$WebTemplate = "68" # 64 Team site template # 1 Team site (with group creation disabled) # 68 Communication site template # 69 Channel site template
$ThumbnailUrl = "https://raw.githubusercontent.com/giuleon/CustomSiteTemplates/main/assets/ContosoPreview1.png"
$PreviewImageUrl = "https://raw.githubusercontent.com/giuleon/CustomSiteTemplates/main/assets/ContosoPreview1.png"
$TenantName = "giulianodemo"
$SiteScriptJson = ".\SiteScriptContoso.json"
$SiteScriptJsonContent = Get-Content $SiteScriptJson -Raw

Connect-SPOService -Url https://$TenantName-admin.sharepoint.com

#Creating a new Site Script & Site Design
$SiteScript = Add-SPOSiteScript -Title $Title -Description $Description -Content $SiteScriptJsonContent
Add-SPOSiteDesign `
  -Title $Title `
  -Description $Description `
  -SiteScripts $SiteScript.Id `
  -WebTemplate $WebTemplate

#Updating an existing one
Get-SPOSiteDesign c765f79a-2bcf-4eec-923d-0b874ec57453
Set-SPOSiteDesign -Identity c765f79a-2bcf-4eec-923d-0b874ec57453 `
    -ThumbnailUrl $ThumbnailUrl `
    -PreviewImageUrl $PreviewImageUrl

Get-SPOSiteScript 9823d5c9-e8d5-49e1-aa23-6bebea62b82c
Set-SPOSiteScript -Identity 9823d5c9-e8d5-49e1-aa23-6bebea62b82c -Content $script



