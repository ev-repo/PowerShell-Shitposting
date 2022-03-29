<#
Name: CSV-UserCreate.ps1
Version 0.0
Description: Doesn't work, testing bulk creation of AD users through CSV, will contiunue to update
Author: Evan Berkowitz
Date: 3/29/2022

:trollface:
#>

Add-Type -AssemblyName 'System.Web'
  

$ADUsers = Import-Csv $args[0] 

foreach ($User in $ADUsers) {
    $firstName = $User.First
    $lastName = $User.Last
    $email = $User.Email
    $username = $User.Username
    $phone = $User.Phone
    $OU = $User.OU
    $groups = $User.Groups
}

#splits the mf array
$groupArray = $groups -split ", "

#testing variables work
foreach ($group in $groupArray){
    Write-Host $group
}

Write-Host $firstName
Write-Host $lastName
Write-Host $email
Write-Host $username
Write-Host $phone
