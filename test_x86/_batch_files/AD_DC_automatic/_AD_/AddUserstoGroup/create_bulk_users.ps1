Import-Module ActiveDirectory
$totalusers = 10
for ($i=0; $i -lt $totalusers; $i++) 
 { 
 $userID = "{0:00}" -f ($i + 1)
 $userName = "TestUser$userID"
 
 Write-Host "Creating AD user" ($i + 1) "of" $totalusers ":" $userName
 
New-ADUser `
 -Name $userName  `
 -Path  "OU=OT,DC=OT,DC=Local" `
 -SamAccountName $userName `
 -AccountPassword (ConvertTo-SecureString "MyPassword123" -AsPlainText -Force) `
 -Enabled $true
 Add-ADGroupMember "Domain Admins" $userName;
}
