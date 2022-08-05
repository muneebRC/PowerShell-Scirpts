Set-ExecutionPolicy -ExecutionPolicy Remotesigned -Scope CurrentUser -Verbose
Import-Module ActiveDirectory
Set-Location AD:
New-ADUser -SamAccountName "firstL" -Name "first1 last3" -GivenName "first" -Surname "last" -DisplayName "First Last" -PasswordNeverExpires $true -UserPrincipalName "first.lasts@mssfulfillment.com" -Path "OU=S4LYN,OU=MSS,DC=mssfulfillment,DC=com" -AccountPassword(ConvertTo-SecureString "123summer" -AsPlainText -Force) -ScriptPath "login.bat" -Enabled $true -Verbose
$refuser = get-aduser -Identity dianaA -Properties Memberof
$refmemberof = $refuser.MemberOf
$refmemberof | Add-ADGroupMember -Members firstL

get-aduser -Identity tempuser -properties memberof | Select-Object -ExpandProperty memberof |  Add-ADGroupMember -Members firstL

Set-ExecutionPolicy -ExecutionPolicy Restricted -Scope CurrentUser -Verbose
