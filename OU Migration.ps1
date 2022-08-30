Write-Host Migration script started...
Clear-Host
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }
Add-Type -AssemblyName System.Windows.Forms
$CompDN = ([ADSISEARCHER]"sAMAccountName=$($env:COMPUTERNAME)$").FindOne().Path
$CompObj = [ADSI]"$CompDN"
$HostNAme = $env:COMPUTERNAME

if ($env:computerName.contains("S4FOR")) {
         $OU = "OU=Forest (FOR),OU=Domain Computers,DC=DOMAIN,DC=com"
         try {
            
            $CompObj.psbase.MoveTo([ADSI]"LDAP://$($OU)") ;
            [System.Windows.Forms.MessageBox]::Show("$HostNAme successfully migrated to 'FOR' OU...")
            }
            catch {
            $_.Exception.Message ; [System.Windows.Forms.MessageBox]::Show('Computer migration failed due to error...')  
            } 
}

elseif($env:computerName.contains("S4MUR")) {
    $OU = "OU=Murray (MUR),OU=Domain Computers,DC=DOMAIN,DC=com"
         try {
            
           
            $CompObj.psbase.MoveTo([ADSI]"LDAP://$($OU)") ;
            [System.Windows.Forms.MessageBox]::Show("$HostNAme successfully migrated to the 'MUR' OU...")
            }
            catch {
            $_.Exception.Message ;[System.Windows.Forms.MessageBox]::Show('Computer migration failed due to error...')  
            }
}
elseif($env:computerName.contains("S4LYN")) {
    $OU = "OU=Lynchburg (LYN),OU=Domain Computers,DC=DOMAIN,DC=com"
         try {
            
            
            $CompObj.psbase.MoveTo([ADSI]"LDAP://$($OU)") ;
            [System.Windows.Forms.MessageBox]::Show("$HostNAme successfully migrated to the 'LYN' OU...")
            }
            catch {
            $_.Exception.Message ;[System.Windows.Forms.MessageBox]::Show('Computer migration failed due to error...')  
            } 
}

else {
    
Write-Host ""
Write-Host "========================================"
Write-Host "       Migrate Computer OU"
Write-Host "========================================"
Write-Host ""
Write-Host "This script will migrate the computer $HostNAme"
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
    
    Write-Host "      1: Press '1' for LOC (FOR)"
    Write-Host "      2: Press '2' for LOC (MUR)"
    Write-Host "      3: Press '3' for LOC (LYN)"
    Write-Host "      Q: Press 'Q' to quit."
}
Show-Menu –Title 'OU Options'
Write-Host ""
$selection = Read-Host "Please make a selection"
switch ($selection)
 {
     '1' {
         $OU = "OU=Forest (FOR),OU=Domain Computers,DC=DOMAIN,DC=com"
         try {
            
            
            $CompObj.psbase.MoveTo([ADSI]"LDAP://$($OU)") ;
            [System.Windows.Forms.MessageBox]::Show("$HostNAme successfully migrated to the 'FOR' OU...")
            }
            catch {
            $_.Exception.Message ; Exit 1
            }

     } '2' {
         $OU = "OU=Murray (MUR),OU=Domain Computers,DC=DOMAIN,DC=com"
         try {
            
           
            $CompObj.psbase.MoveTo([ADSI]"LDAP://$($OU)");
            [System.Windows.Forms.MessageBox]::Show("$HostNAme successfully migrated to the 'MUR' OU...")
            }
            catch {
            $_.Exception.Message ; Exit 1
            }
     } '3' {
         $OU = "OU=Lynchburg (LYN),OU=Domain Computers,DC=DOMAIN,DC=com"
         try {
            
            
            $CompObj.psbase.MoveTo([ADSI]"LDAP://$($OU)");
            [System.Windows.Forms.MessageBox]::Show("$HostNAme successfully migrated to the 'LYN' OU...")
            }
            catch {
            $_.Exception.Message ; Exit 1
            }
     } 'q' {[System.Windows.Forms.MessageBox]::Show("$HostNAme was not migrated...");
         return
     }
 }

$CompDNNew = ([ADSISEARCHER]"sAMAccountName=$($env:COMPUTERNAME)$").FindOne().Path
Write-Host ""
Write-Host "Results:"
Write-Host ""
Write-Host "Old OU: $CompDN"
Write-Host "New OU: $CompDNNew"
Write-Host ""
Read-Host -Prompt "Press ENTER key to exit..."
return
}


