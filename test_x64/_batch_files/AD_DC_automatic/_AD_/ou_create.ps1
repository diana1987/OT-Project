import-module activedirectory
Get-Content OUStructure.txt | Foreach-Object {  
$domene = 'DC=ot,DC=local'  
$alleOU = '' 
$ous = (Split-Path $_ -Parent).Split('\')  
[array]::Reverse($ous)  
$ous | Foreach-Object { 
   if ($_.Length -eq 0) {  
    	return    
	}   
	$alleOU = $alleOU + 'OU=' + $_ + ','  
    }  
$alleOU += $domene 
$nyOUNavn = Split-Path $_ -Leaf

New-ADOrganizationalUnit -Name "$nyOUNavn" -Path "$alleOU" -ProtectedFromAccidentalDeletion $false
}

