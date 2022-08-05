if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))  
{  
  $arguments = "& '" +$myinvocation.mycommand.definition + "'"
  Start-Process powershell -Verb runAs -ArgumentList $arguments
  Break
}

Clear-Host
$CompDN = ([ADSISEARCHER]"sAMAccountName=$($env:COMPUTERNAME)$").FindOne().Path
$CompObj = [ADSI]"$CompDN"
Write-Host ""
Write-Host "========================================"
Write-Host "       Migrate Computer OU"
Write-Host "========================================"
Write-Host ""
Write-Host "This script will migrate the current computer "
Write-Host "to the user designated OU (FOR, MUR, or LYN)"
Write-Host ""
Write-Host "Current OU hierarchy:"
Write-Host "$CompDN"
Write-Host ""

function Show-Menu {
    param (
        [string]$Title = 'My Menu'
    )
    
    Write-Host "================ $Title ================"
    
    Write-Host "      1: Press '1' for OU1"
    Write-Host "      2: Press '2' for OU2"
    Write-Host "      3: Press '3' for OU3"
    Write-Host "      Q: Press 'Q' to quit."
}
Show-Menu –Title 'OU Options'
Write-Host ""
$selection = Read-Host "Please make a selection"
switch ($selection)
 {
     '1' {
         $OU = "OU=OU1,OU=Domain Computers,DC=mssfulfillment,DC=com"
         try {
            
            
            $CompObj.psbase.MoveTo([ADSI]"LDAP://$($OU)")
            }
            catch {
            $_.Exception.Message ; Exit 1
            }

     } '2' {
         $OU = "OU=OU2,OU=Domain Computers,DC=DOMAIN,DC=com"
         try {
            
           
            $CompObj.psbase.MoveTo([ADSI]"LDAP://$($OU)")
            }
            catch {
            $_.Exception.Message ; Exit 1
            }
     } '3' {
         $OU = "OU=OU3,OU=Domain Computers,DC=DOMAIN,DC=com"
         try {
            
            
            $CompObj.psbase.MoveTo([ADSI]"LDAP://$($OU)")
            }
            catch {
            $_.Exception.Message ; Exit 1
            }
     } 'q' {
         return
     }
 }
Write-Progress -Activity "Migrating $env:COMPUTERNAME to $OU OU within ActiveDirectory Domain Computers" -Status "Performing Opperation..." -PercentComplete 33
Start-Sleep -Seconds 1
Write-Progress -Activity "Migrating $env:COMPUTERNAME to $OU OU within ActiveDirectory Domain Computers" -Status "Performing Opperation..." -PercentComplete 66
Start-Sleep -Seconds 1
Write-Progress -Activity "Migrating $env:COMPUTERNAME to $OU OU within ActiveDirectory Domain Computers" -Status "Performing Opperation..." -PercentComplete 100
Start-Sleep -Seconds 1
Write-Progress -Activity "Migrating $env:COMPUTERNAME to $OU OU within ActiveDirectory Domain Computers" -Status "Performing Opperation..." -Completed
$CompDNNew = ([ADSISEARCHER]"sAMAccountName=$($env:COMPUTERNAME)$").FindOne().Path
Write-Host ""
Write-Host "Results:"
Write-Host ""
Write-Host "Old OU: $CompDN"
Write-Host "New OU: $CompDNNew"
Write-Host ""
Read-Host "Press Enter to quit..."
return


