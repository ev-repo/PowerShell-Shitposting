<#
Name: Recover-Emails.ps1
Version 1.0
Description: Recovers emails
Author: Evan
Date: 03/25/2022

PLEASE DO NOT USE, THIS SUCKS
#>

$startPrompt
$endPrompt 

$User = Read-Host -Prompt 'Please enter the mailbox of the user'
$Subject = Read-Host -Prompt 'Enter the subject of the item'


$startTime = Read-Host -Prompt "Enter the start time (M/D/YYYY HH:MM:SS AM/PM)"
if ($startTime){
    $startPrompt = "-FilterStartTime"
}


$endTime = Read-Host -Prompt "Enter the end time (M/D/YYYY HH:MM:SS AM/PM)"
if ($endTime){
    $endPrompt = "-FilterEndTime"
}

Get-RecoverableItems -Identity $User $startTime $endTime -SubjectContains $Subject

$confirmation = Read-Host "Would you like to recover the above messages?"
if ($confirmation -eq 'y') {
    Recover-RecoverableItems -Identity $User $endPrompt $startTime $endPrompt $endTime -SubjectContains $Subject
}

