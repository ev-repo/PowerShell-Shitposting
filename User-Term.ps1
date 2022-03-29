<#
Name: User-Term.ps1
Version 1.0
Description: Generates random PW, disables account, and can remove from distribution groups
Author: Evan Berkowitz
Date: 03/29/2022

MADE THIS BECAUSE I WAS BORED, USELESS SCRIPT, DO IT THE REGULAR WAY
#>

Add-Type -AssemblyName 'System.Web'
$newPW = [System.Web.Security.Membership]::GeneratePassword(10, 5)

$User = Read-Host -Prompt 'Please enter the username of the user'

Set-ADAccountPassword -Identity $User -NewPassword (ConvertTo-SecureString -AsPlainText $newPW -Force)
Disable-ADAccount -Identity $User

$removalOption = Read-Host -Prompt 'Would you like to remove the user from ALL groups?'
$allGroups= Get-DistributionGroup

if ($removalOption -eq "y"){
    foreach($group in $allGroups){
        Remove-DistributionGroupMember $group -Member "user@domain.com"
    }
}