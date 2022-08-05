Clear-Host
Write-Host ""
Write-Host "========================================"
Write-Host "       Unlock AD User"
Write-Host "========================================"
Write-Host ""
Write-Host "This script will unlock the"
Write-Host "specified user account..."
Write-Host ""
Write-Host ""
while ($true) {
     
 
$name = Read-Host "Please type the user account and press enter or q to quit"

function Test-ADUser {
  param(
    [Parameter(Mandatory = $true)]
    [String] $sAMAccountName
  )
  $null -ne ([ADSISearcher] "(sAMAccountName=$sAMAccountName)").FindOne()
}

if ( 'q' -eq $name )
{
    return
}

$val = Test-ADUser -sAMAccountName $name

if ("True" -eq $val) {

Unlock-ADAccount -Identity $name
write-host ""
write-host ""
write-host("User $name unlocked...")
write-host ""
write-host ""
}else {
   write-host ""
   write-host ""
   write-host("please enter a valid AD user ID...")
   write-host ""
   write-host ""
}

} 