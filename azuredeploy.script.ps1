param(
 
 
# [Parameter(Mandatory=$true)] 
# [String] $aq  
 
)

#Read-Host "Enter AQ"
#Write-Host $aq



#Login-AzureRmAccount
#Get-AzureRmSubscription
Select-AzureRmSubscription -SubscriptionId 3a4af7b3-b7ac-463d-9940-1d80445961a8
#Set-AzureRmContext -SubscriptionID 3a4af7b3-b7ac-463d-9940-1d80445961a8

#$srNumber = Read-Host ("SR Number ") # 'm2016'
$srNumber = 'd2016'

$resourceGroupName = 'RGsp' + $srNumber
$location = 'east us 2'

$deploymentName = 'sp-' + $srNumber
$storageAccountNamePrefix  = 'storage' + $srNumber

$sharepointFarmName = 'spfarm' + $srNumber
$virtualNetworkName = 'spfarmVNET'+ $srNumber
#$sppuplicIP = 'sppuplicIP'

New-AzureRmResourceGroup -Name $resourceGroupName -Location $Location -Verbose -Force

$sppublicIP = New-AzureRmPublicIpAddress -AllocationMethod Dynamic -ResourceGroupName $resourceGroupName -Name $sppuplicIPName  -Location $location

$parameters=@{


sharepointFarmName = $sharepointFarmName
location ='east us'
virtualNetworkName= $virtualNetworkName
virtualNetworkAddressRange='10.0.0.0/16'
adSubnet='10.0.0.0/24'
sqlSubnet='10.0.1.0/24'
spSubnet= '10.0.2.0/24'
adNicIPAddress='10.0.0.4'
adminUsername = 'adiy'
adminPassword='P@ssw0rd1234'
adVMSize = 'Standard_D2_v2'
sqlVMSize = 'Standard_D2_v2'
spVMSize='Standard_D5_V2'
domainName= 'adiy.local' 
sqlServerServiceAccountUserName='adiysql'
sqlServerServiceAccountPassword='P@ssw0rd1234'
sharePointSetupUserAccountUserName='adiysp'
sharePointSetupUserAccountPassword= 'P@ssw0rd1234'
sharePointFarmAccountUserName='sp_farm'
sharePointFarmAccountPassword= 'P@ssw0rd1234'
sharePointFarmPassphrasePassword='P@ssw0rd1234'
spSiteTemplateName='STS#0'
spDNSPrefix='sp-unique' + $srNumber
#baseUrl='https://raw.githubusercontent.com/aayad/sharepoint-three-vm/master'
baseUrl = 'https://raw.githubusercontent.com/aqasrawi/sp2013/master'
#baseUrl = 'https://raw.githubusercontent.com/razar-msft/SharePoint-Non-HA-FARM/master'
spPublicIPNewOrExisting='new'
spPublicIPRGName=''
sppublicIPAddressName= $sppuplicIP
storageAccountNamePrefix= $storageAccountNamePrefix
storageAccountType='Standard_LRS'

}

#New-AzureRmResourceGroup `
#    -Name $resourceGroupName `
#    -Location $Location `
#    -Verbose -Force



New-AzureRmResourceGroupDeployment -Name $deploymentName -ResourceGroupName $resourceGroupName -TemplateFile "C:\Users\aqasrawi\Documents\GitHub\SP2013\azuredeploy.json" -TemplateParameterObject $parameters -Verbose


