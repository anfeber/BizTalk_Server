##############################################################################################
#
# Description: Script for change the user and Credentials of all AppPool for Specific User,  #
#              The change allow obtain configurations in IIS.                                # 
#
##############################################################################################

Import-Module WebAdministration

# Get information from the AppPool Before
Get-ciminstance -namespace root/microsoftiisv2 -classname iisapplicationpoolsetting -property Name, WAMUserName, WAMUserPass | select Name, WAMUserName, WAMUserPass

# Domain and user to change
$UserName = "Domain\User"

#Password for Change
$Pwd = "P@ssw0rd"

$applicationPools = Get-ChildItem IIS:AppPools | where { $_.processModel.userName -eq $UserName }
foreach($pool in $applicationPools)
{
     $pool.processModel.userName = $UserName
     $pool.processModel.password = $Pwd
     $pool | Set-Item
}
Write-Host "Application pool passwords updated..." -ForegroundColor Green
Write-Host "" 
Read-Host -Prompt "Press Enter to exit"


# Get information from the AppPool, After running the Script
Get-ciminstance -namespace root/microsoftiisv2 -classname iisapplicationpoolsetting -property Name, WAMUserName, WAMUserPass | select Name, WAMUserName, WAMUserPass
