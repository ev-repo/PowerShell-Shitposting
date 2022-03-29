<#
Name: CSV-UserCreate.ps1
Version 1.1
Description: MIGHT create new users from .csv (probably not), no clue don't have AD environment to test it rn 
Author: Evan Berkowitz
Date: 3/29/2022

:trollface:
#>

Add-Type -AssemblyName 'System.Web'
$ADUsers = Import-Csv $args[0] 

foreach ($User in $ADUsers) {
    #Takes data from CSV file
    $firstName = $User.First
    $lastName = $User.Last
    $email = $User.Email
    $username = $User.Username
    $phone = $User.Phone
    $OU = $User.OU

    #Password maker 9000
    $userPW = [System.Web.Security.Membership]::GeneratePassword(10, 3)

    #Creates AD user using info given
    New-ADUser -GivenName $firstName -Surname $lastName -SamAccountName $username -EmailAddress $email -OfficePhone $phone -Path $OU -AccountPassword (ConvertTo-SecureString $userPW -AsPlainText -Force)
    Write-Host "Created user $username 'nPassword: $userPW"

    #BOMB ASS GROUP ADDER
    $groups = $User.Groups
    $groupArray = $groups -split ", "
    foreach ($group in $groupArray){
        Add-ADGroupMember -Identity $group -Members $User
        Write-Host "Added $username to $group"
    }
}