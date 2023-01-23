##############################################################################################
#
# Description: Script for change the user and Credentials of all Host Instances in BizTalk,  #
#              The change allow obtain configurations between Windows Services and           #
#              setthing in administration Console, as you can see in the follow pictures.    # 
#
##############################################################################################

# Getting the list of BizTalk Host Instances objects
$AllHosts = Get-WmiObject -namespace 'root/MicrosoftBizTalkServer' -query 'select * from MSBTS_HostInstance'

# Listing names existing BizTalk Host Instances
$HostName = $AllHosts.hostname

# Every HI for change PSW
foreach($hi in $AllHosts ){

       if (($hi.HostName -like "*Host_Instances_BizTalk") -or ($hi.HostName -eq "BTS_Host_XYZ") ){
          Write-Host "HostInstance In-Process" -ForegroundColor Green
          # Save Host
          echo $hi.HostName >> "C:\Temp\HI_In-Process.txt"
          Write-Host "Cambiar password $hi.HostName"
          $hi.Install("Domain\User", "P@55w0rd", "true")
    }
    else{
        Write-Host "Host Isolated"
        echo $hi.HostName >> "C:\Temp\HI_Isolated.txt"
        $hi.Install("Domain\User", "P@ssW0rd", "true")
    }
}
