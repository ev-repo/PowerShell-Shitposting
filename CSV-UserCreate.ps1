<#
Name: CSV-UserCreate.ps1
Version 1.2
Description: Takes an input from a .csv file and creates AD users 
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
    $title = $User.Title
    $OU = $User.OU

    #Password maker 9000
    $userPW = [System.Web.Security.Membership]::GeneratePassword(10, 3)

    #Creates AD user using info given, also generates password which is cool
    New-ADUser `
            -GivenName $firstName `
            -Surname $lastName `
            -Name $firstName $lastName `
            -SamAccountName $username `
            -EmailAddress $email `
            -OfficePhone $phone `
            -Title $title `
            -Path $OU `
            -AccountPassword (ConvertTo-SecureString $userPW -AsPlainText -Force) `
            -ChangePasswordAtLogon $True

    Write-Host "Created user $username `nPassword: $userPW"

    #BOMB ASS GROUP ADDER
    $groups = $User.Groups
    $groupArray = $groups -split ", "
    foreach ($group in $groupArray){
        Add-ADGroupMember -Identity $group -Members $User
        Write-Host "Added $username to $group"
    }
    Write-Host "`n"
}